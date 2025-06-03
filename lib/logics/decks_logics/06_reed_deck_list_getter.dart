//------------------------------------------------------------------------------
// Loverquest - https://github.com/H3rz3n/loverquest/
//
// Copyright (C) 2025 Lorenzo Maiuri & Contributors
//
// This file is part of Loverquest.
//
// Loverquest is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Loverquest is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Loverquest.  If not, see <https://www.gnu.org/licenses/>.
//
//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';

// HIVE
import 'package:hive_flutter/hive_flutter.dart';

//------------------------------------------------------------------------------
// METHOD TO GET WHICH SYSTEM LANGUAGE IS IN USE
String get_system_language(BuildContext context) {

  // GETTING THE APP LANGUAGE
  Locale locale = Localizations.localeOf(context);

  // RETURNING THE VALUE
  return locale.languageCode;

}

//------------------------------------------------------------------------------

// METHOD TO GET ALL THE DEFAULT DECK FILE PATH WITH OPTIONAL FILTERS
Future<List<DeckReader>> get_default_reed_decks (BuildContext context, {bool? is_presence}) async {

  // GETTING THE SYSTEM LANGUAGE
  String lang = get_system_language(context);

  // CHECKING IF THE LANGUAGE IS ACTUALLY SUPPORTED
  if (lang != "en" && lang != "it" && lang != "es" && lang != "fr" && lang != "de" && lang != "nl") { lang = "en"; }

  // INITIALIZING THE PRESENCE/DISTANCE FOLDERS SEARCHING LIST
  List<String> folders;

  // CHECKING IF WE ARE FILTERING ONLY FOR PRESENCE / DISTANCE DECKS
  if (is_presence == null) {
    folders = ["presence", "distance"];
  } else {
    folders = [is_presence ? "presence" : "distance"];
  }

  // INITIALIZING THE DECKS FILE PATHS LIST
  List<String> file_paths = [];

  // USING TRY TO AVOID CRITICAL ERRORS
  try {

    // LOADING THE ENTIRE CONTENT OF THE APP ASSETS LIST AS JSON FILE
    final String assets_manifest_file = await rootBundle.loadString('AssetManifest.json');

    // DECODING THE JSON FILE IN A STRING
    final Map<String, dynamic> manifestMap = json.decode(assets_manifest_file);

    // LOADING THE DECK PATH FOR THE CHOOSE FILTER OPTION - PRESENCE - DISTANCE - BOTH
    for (String folder in folders) {

      // DEFINING THE DECK PREFIX IN ORDER TO SEARCH ONLY FOR THE DESIRED DECKS - DEFAULT PATH - PRESENCE/DISTANCE - LANG
      String deck_path_prefix = "assets/default_decks/$folder/$lang/";

      // FILTERING THE GET ASSETS LIST USING THE PATH PREFIX STRING DEFINED EARLY
      manifestMap.keys.where((String key) => key.startsWith(deck_path_prefix)).forEach((String key) {

        // ADDING THE PATH TO THE FILE PATH LIST IF IT IS ADEQUATE
        file_paths.add(key);
      });

    }

    // INITIALIZING THE DEFAULT REED DECKS LIST
    List<DeckReader> default_reed_deck_list = [];

    // FOR EVERY FILE PATH IN THE LIST WILL BE CREATED AN ELEMENT INSIDE A TEMP LIST WHERE LOAD THE DECK ELEMENTS
    for (String deck_path in file_paths) {

      // CREATING DECK READER OBJECT
      DeckReader deckManager = DeckReader(deck_path);

      // LOADING DECK DATA ASYNCHRONOUSLY
      await deckManager.load_deck();

      // ADDING THE LOADED DECK TO THE TMP LIST
      default_reed_deck_list.add(deckManager);
    }

    // RETURNING THE DEFAULT REED DECK LIST
    return default_reed_deck_list;

  } catch (e) {

    // RETURNING AND EMPTY LIST IN ORDER TO NOT BREAK THE APP
    //print("DEBUG | ERROR LOADING THE DECKS FILES: $e");

    return [];
  }
}

//------------------------------------------------------------------------------

// METHOD TO GET ALL THE DEFAULT DECK FILE PATH WITH OPTIONAL FILTERS
Future<List<DeckReader>> get_custom_hive_reed_decks () async {

  // OPEN THE HIVE CUSTOM DECKS BOX
  final box = await Hive.openBox('customDecks');

  // GETTING ALL THE DECKS KEYS
  List<String> decks_keys = box.keys.cast<String>().toList();

  // INITIALIZING THE CUSTOM REED DECKS LIST
  List<DeckReader> custom_reed_deck_list = [];

  // LOADING THE DECKS DATA INSIDE THE CUSTOM REED DECKS LIST
  for (String deck_key in decks_keys) {

    // INITIALIZING THE DECK OBJECT
    DeckReader deck_object = DeckReader(deck_key);

    // LOADING THE DECK DATA
    await deck_object.load_deck();

    // ADDING THE DECK DATA TO THE DECK LIST
    custom_reed_deck_list.add(deck_object);

  }

  // RETURNING THE CUSTOM REED DECK LIST
  return custom_reed_deck_list;

}

//------------------------------------------------------------------------------
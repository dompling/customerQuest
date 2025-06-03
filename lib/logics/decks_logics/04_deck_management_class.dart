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
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';

// HIVE
import 'package:hive/hive.dart';

// CUSTOM FILE
import 'package:loverquest/logics/decks_logics/00_legacy_deck_reader_class.dart';
import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';
import 'package:loverquest/logics/decks_logics/02_deck_summary_class.dart';
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';
import 'package:path_provider/path_provider.dart';

//------------------------------------------------------------------------------


// DECK MANAGEMENT CLASS - CONTAINS METHODS TO SAVE QUEST AND SAVE, IMPORT AND EXPORT DECKS
class DeckManagement {

  //------------------------------------------------------------------------------

  // ignore: constant_identifier_names
  static const String hive_box_name = "customDecks";

  //------------------------------------------------------------------------------

  // METHOD FOR SAVING ENTIRE DECK
  static Future<String> save_deck({required String deck_name, required String deck_description, required String deck_language, required String couple_type, required bool play_presence, required List<String> deck_tags, DeckReader? already_existing_deck, LegacyDeckReader? legacy_already_existing_deck, bool deck_duplication = false}) async {
    try {

      // INITIALISING THE QUEST NUMBER VAR
      int deck_quest_number = 0;

      // INITIALIZING THE DECK TOOLS LIST
      List<String> deck_tools_list = [];

      // DEFINING THE HIVE BOX VAR
      Box box;

      // INITIALIZING THE NEW DECK KEY VAR
      String deck_key;
      
      //------------------------------------------------------------------------------

      // CHECKING IF THE BOX WAS PREVIOUSLY OPENED
      if (Hive.isBoxOpen(hive_box_name)) {

        // LOADING THE PREVIOUSLY OPENED INSTANCE
        box = Hive.box(hive_box_name);

      } else {

        // OPENING A NEW INSTANCE
        box = await Hive.openBox(hive_box_name);

      }

      //------------------------------------------------------------------------------

      // CHECKING IF WE ARE SAVING A PREVIOUSLY EXISTING DECK
      if (already_existing_deck != null && deck_duplication == false) {
        
        // ACQUIRING THE DECK QUEST NUMBER
        deck_quest_number = already_existing_deck.quests.length;

        // SETTING THE DECK KEY TO USE FOR SAVING
        deck_key = already_existing_deck.deck_key;

      } else if (already_existing_deck != null && deck_duplication == true) {

        // ACQUIRING THE DECK QUEST NUMBER
        deck_quest_number = already_existing_deck.quests.length;

        // SETTING THE DECK KEY TO USE FOR SAVING
        deck_key = deck_name;

      } else {

        // SETTING THE DECK KEY TO USE FOR SAVING
        deck_key = deck_name;

      }

      //------------------------------------------------------------------------------

      // CHECKING IF IS POSSIBLE TO GET DECK TOOLS DYNAMICALLY FROM THE QUESTS
      if (already_existing_deck != null && already_existing_deck.quests.isNotEmpty) {

        // ITERATING THE QUEST LIST
        for (Quest current_quest in already_existing_deck.quests) {

          // ITERATING THE QUEST TOOLS LIST
          for (String tool in current_quest.required_tools) {

            // CHECKING IF WE ALREADY ADDED THE TOOL TO THE DECK TOOLS LIST
            if (!deck_tools_list.contains(tool)) {

              // ADDING THE TOOL TO THE DECK TOOLS LIST
              deck_tools_list.add(tool);

            }

          }

        }

      }

      //------------------------------------------------------------------------------

      // CREATION OF THE NEW DECK SUMMARY
      DeckSummary new_deck_summary = DeckSummary(

        name: deck_name,                          // PASSED DATA
        description: deck_description,            // PASSED DATA
        couple_type: couple_type,                 // PASSED DATA
        play_presence: play_presence,             // PASSED DATA
        language: deck_language,                  // PASSED DATA
        total_quests: deck_quest_number,          // GOT IN SAVE FUNCTION
        required_tools: deck_tools_list,          // GOT IN SAVE FUNCTION
        tags: deck_tags,                          // PASSED DATA
      );

      //------------------------------------------------------------------------------

      // CREATION OF THE DECK DATA STRUCTURE
      Map<String, dynamic> new_deck_data = {
        "summary": new_deck_summary,                                            // GOT IN SAVE FUNCTION - USING PASSED DATA
        "quests": already_existing_deck?.quests ?? [],                          // PASSED DATA - IF ABSENT GOT IN SAVE FUNCTION
        "deck_key": already_existing_deck?.deck_key ?? deck_key,                // PASSED DATA -  IF ABSENT GOT IN SAVE FUNCTION
      };

      //------------------------------------------------------------------------------

      // SAVING AN EDITED DECK
      if (already_existing_deck != null && deck_duplication == false) {

        // SAVING THE NEW DECK
        await box.put(deck_key, new_deck_data);

        // RETURNING THE DECK KEY
        return deck_key;

      }

      //------------------------------------------------------------------------------

      // SAVING A DUPLICATED DECK
      if (already_existing_deck != null && deck_duplication == true) {

        // INITIALIZING THE COUNTER
        int counter = 1;

        // COPYING THE DECK KEY IN TMP VAR
        String tmp_key = deck_key;

        // CHECKING IF ALREADY EXIST A KEY WITH THE SAME NAME OF THE LOADED DECKS ONE
        while (box.containsKey(deck_key)) {

          // UPDATING THE KEY NAME IN ORDER TO AVOID OVERWRITING
          deck_key = '${counter}_$tmp_key';
          counter++;

        }

        // SAVING THE NEW DECK
        await box.put(deck_key, new_deck_data);

        // RETURNING THE DECK KEY
        return deck_key;

      }

      //------------------------------------------------------------------------------

      // SAVING A NEW DECK
      if (already_existing_deck == null && deck_duplication == false && deck_key == deck_name) {

        // SAVING THE NEW DECK
        await box.put(deck_key, new_deck_data);

        // RETURNING THE DECK KEY
        return deck_key;

      }

      //------------------------------------------------------------------------------

      // ERROR
      throw Exception("ERROR | There was an error saving the deck");

    } catch (e) {

      // ERROR
      throw Exception("ERROR | There was an error saving the deck: $e");

    }
  }

  //------------------------------------------------------------------------------

  // METHOD FOR SAVING A SINGLE QUEST
  static Future<void> save_quest({required DeckReader already_existing_deck, required Quest new_quest,}) async {
    try {
      already_existing_deck.quests.add(new_quest);

      await save_deck(
        deck_name: already_existing_deck.summary.name,
        deck_description: already_existing_deck.summary.description,
        deck_language: already_existing_deck.summary.language,
        couple_type: already_existing_deck.summary.couple_type,
        play_presence: already_existing_deck.summary.play_presence,
        deck_tags: already_existing_deck.summary.tags,
        already_existing_deck: already_existing_deck,
      );
    } catch (e) {
      throw Exception("[ERROR] - There was an error saving the quest: $e");
    }
  }

  //------------------------------------------------------------------------------

  // METHOD TO IMPORT DECK JSON FILE INTO HIVE
  static Future<bool> import_json_file_to_hive() async {
    try {
      
      // SELECTING THE JSON FILE TO IMPORT
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      // CHECKING IF THE REQUEST HAS BEEN ABORTED
      if (result == null) return true;

      // DEFINING THE JSON VAR
      String json_string;

      // CHECKING IF THE FILE WAS CORRECTLY LOADED
      if (result.files.single.bytes != null) {

        // FILE DECODING FOR WEB APP
        json_string = utf8.decode(result.files.single.bytes!);

      } else {

        // FILE DECODING FOR ANDROID AND DESKTOP
        final file = File(result.files.single.path!);
        json_string = await file.readAsString();

      }

      // DECODING THE DECK FILE
      final jsonData = jsonDecode(json_string);

      // OBTAINING THE DECK SUMMARY INFO
      final summary = DeckSummary.fromJson(jsonData['summary']);

      // OBTAINING THE QUESTS INFO
      final quests = (jsonData['quests'] as List).map((q) => Quest.fromJson(q)).toList();

      // DEFINING THE DECK HIVE KEY AS THE DECK NAME
      String deck_key = summary.name;

      // OPENING THE HIVE CONTAINER
      final box = await Hive.openBox('customDecks');

      // INITIALIZING THE COUNTER
      int counter = 1;

      // COPYING THE DECK KEY IN TMP VAR
      String tmp_key = deck_key;

      // CHECKING IF ALREADY EXIST A KEY WITH THE SAME NAME OF THE LOADED DECKS ONE
      while (box.containsKey(deck_key)) {

        // UPDATING THE KEY NAME IN ORDER TO AVOID OVERWRITING
        deck_key = '${counter}_$tmp_key';
        counter++;

      }

      // SAVING THE LOADED DECK IN THE HIVE APP DATABASE
      await box.put(deck_key, {
        'summary': summary,
        'quests': quests,
        'deck_key': deck_key,
      });

      // RETURNING TRUE FOR GOOD STATUS
      return true;

    } catch (e) {
      return false;
    }
  }

  //------------------------------------------------------------------------------

  // METHOD TO EXPORT CUSTOM DECKS FROM HIVE TO JSON FILE
  static Future<void> export_json_file_from_hive(String deckKey) async {
    try {
      final box = await Hive.openBox(hive_box_name);
      final data = box.get(deckKey);

      if (data == null) return;

      final summary = data['summary'];
      final quests = data['quests'];

      final jsonMap = {
        'summary': summary.toJson(),
        'quests': (quests as List).map((q) => q.toJson()).toList(),
      };

      final json_string = jsonEncode(jsonMap);
      final bytes = Uint8List.fromList(json_string.codeUnits);

      await FlutterFileSaver().writeFileAsBytes(
        fileName: '$deckKey.json',
        bytes: bytes,
      );
    } catch (e) {
      // gestione errori silenziosa
    }
  }

  //------------------------------------------------------------------------------

  // METHOD TO EXPORT STOCK DECKS TO JSON FILE
  static Future<void> export_json_file(String originalFilePath, String fileName, { bool isAsset = false,}) async {
    Uint8List bytes;

    if (isAsset) {
      // Carica da asset
      final data = await rootBundle.load(originalFilePath);
      bytes = data.buffer.asUint8List();
    } else {
      // Carica da file system
      bytes = await File(originalFilePath).readAsBytes();
    }

    await FlutterFileSaver().writeFileAsBytes(
      fileName: '$fileName.json',
      bytes: bytes,
    );
  }

  //------------------------------------------------------------------------------

  // METHOD TO DELETE A CUSTOM DECK FROM HIVE
  static Future<bool> delete_custom_deck(String deckKey) async {
    try {
      // APRI LA BOX DEI MAZZI PERSONALIZZATI
      final box = await Hive.openBox('customDecks');

      // VERIFICA SE LA CHIAVE ESISTE
      if (box.containsKey(deckKey)) {
        await box.delete(deckKey); // CANCELLA IL MAZZO
        return true;
      } else {
        return false; // MAZZO NON TROVATO
      }
    } catch (e) {
      return false; // ERRORE GENERICO
    }
  }

  //------------------------------------------------------------------------------

  // METHOD TO GET ALL THE CUSTOM DECK FILE PATHS
  static Future<List<String>> get_legacy_custom_deck_paths() async {

    //------------------------------------------------------------------------------

    // GETTING THE APP DOCUMENTS DIRECTORY
    Directory app_document_dir = await getApplicationDocumentsDirectory();

    //------------------------------------------------------------------------------

    // GETTING THE CUSTOM DECKS PATH
    String legacy_custom_decks_path = '${app_document_dir.path}/custom_decks';

    //------------------------------------------------------------------------------

    // CHECKING IF THE FOLDER ALREADY EXIST, OTHERWISE IT WILL BE CREATED
    Directory customDir = Directory(legacy_custom_decks_path);
    if (!customDir.existsSync()) {

      // CREATING THE FOLDER
      customDir.createSync(recursive: true);

    }

    //------------------------------------------------------------------------------

    // GETTING THE FILE LIST
    List<FileSystemEntity> files = customDir.listSync();

    //------------------------------------------------------------------------------

    // CONVERTING THE FILE LIST IN A FILE PATHS LIST
    List<String> file_paths_list = files
        .whereType<File>()
        .map((file) => file.path)
        .toList();

    //------------------------------------------------------------------------------

    // RETURNING THE LIST
    return file_paths_list;

    //------------------------------------------------------------------------------

  }

  // METHOD TO DELETE A SELECTED LEGACY CUSTOM DECK FROM THE APP DOCUMENTS DIRECTORY
  static Future<void> delete_legacy_custom_deck_file(String file_path) async {

    try {

      // GETTING THE FILE
      final File file = File(file_path);

      // CHECKING IF THE FILE EXIST
      if (await file.exists()) {

        // DELETING THE FILE
        await file.delete();

      }

    } catch (e) {
      //print
    }

  }

  // METHOD TO CONVERT LEGACY CUSTOM DECKS TO USE HIVE STORAGE
  static Future<void> convert_legacy_custom_decks_to_hive () async {

    // GETTING THE LEGACY CUSTOM DECKS PATH
    List<String> legacy_custom_decks_paths_list = await get_legacy_custom_deck_paths();

    // ITERATING THE THE LEGACY CUSTOM DECKS PATH LIST
    for (String deck_file_path in legacy_custom_decks_paths_list) {

      // INITIALIZING THE DECK OBJECT
      LegacyDeckReader deck_object = LegacyDeckReader(deck_file_path);

      // LOADING THE DECK INSIDE THE DECK OBJECT
      await deck_object.load_legacy_deck();

      // SAVING THE DECK INSIDE THE HIVE DATABASE
      await save_deck(deck_name: deck_object.summary.name, deck_description: deck_object.summary.description, deck_language: deck_object.summary.language, couple_type: deck_object.summary.couple_type, play_presence: deck_object.summary.play_presence, deck_tags: deck_object.summary.tags, legacy_already_existing_deck: deck_object);

      // DELETING THE LEGACY DECK
      await delete_legacy_custom_deck_file(deck_object.deck_file_path);

    }

  }

  //------------------------------------------------------------------------------

}
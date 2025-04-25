//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
Future<List<String>> get_default_deck_paths(BuildContext context, {bool? is_presence}) async {

  // GETTING THE SYSTEM LANGUAGE
  String lang = get_system_language(context);

  // CHECKING IF THE LANGUAGE IS ACTUALLY SUPPORTED
  if (lang != "en" && lang != "it" && lang != "es" && lang != "fr" && lang != "de") { lang = "en"; }

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

    // RETURNING THE FILE PATHS LIST
    return file_paths;

  } catch (e) {

    // RETURNING AND EMPTY LIST IN ORDER TO NOT BREAK THE APP
    //print("DEBUG | ERROR LOADING THE DECKS FILES: $e");

    return [];
  }
}



//------------------------------------------------------------------------------



//  METHOD TO GET ALL THE CUSTOM DECK FILE PATHS
Future<List<String>> get_custom_deck_paths() async {

  //------------------------------------------------------------------------------

  // GETTING THE APP DOCUMENTS DIRECTORY
  Directory appDocDir = await getApplicationDocumentsDirectory();

  //------------------------------------------------------------------------------

  // GETTING THE CUSTOM DECKS PATH
  String customPath = '${appDocDir.path}/custom_decks';

  //------------------------------------------------------------------------------

  // CHECKING IF THE FOLDER ALREADY EXIST, OTHERWISE IT WILL BE CREATED
  Directory customDir = Directory(customPath);
  if (!customDir.existsSync()) {

    // CREATING THE FOLDER
    customDir.createSync(recursive: true);

  }

  //------------------------------------------------------------------------------

  // GETTING THE FILE LIST
  List<FileSystemEntity> files = customDir.listSync();

  //------------------------------------------------------------------------------

  // CONVERTING THE FILE LIST IN A FILE PATHS LIST
  List<String> filePaths = files
      .whereType<File>()
      .map((file) => file.path)
      .toList();

  //------------------------------------------------------------------------------

  // RETURNING THE LIST
  return filePaths;

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------
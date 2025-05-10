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
  static Future<String> save_deck({required String deck_name, required String deck_description, required String deck_language, required String couple_type, required bool play_presence, required List<String> deck_tags, DeckReader? selected_deck, LegacyDeckReader? legacy_selected_deck, String? original_deck_key,}) async {
    try {

      // INITIALISING THE QUEST NUMBER VAR
      int deck_quest_number = 0;

      if (selected_deck != null) {

        deck_quest_number = selected_deck.quests.length;

      } else if (legacy_selected_deck != null) {

        deck_quest_number = legacy_selected_deck.quests.length;

      }

      List<String> deck_quest_tools = [];
      if (selected_deck != null && selected_deck.quests.isNotEmpty) {
        for (Quest current_quest in selected_deck.quests) {
          for (String tool in current_quest.required_tools) {
            if (!deck_quest_tools.contains(tool)) {
              deck_quest_tools.add(tool);
            }
          }
        }
      }

      DeckSummary new_summary = DeckSummary(
        name: deck_name,
        description: deck_description,
        couple_type: couple_type,
        play_presence: play_presence,
        language: deck_language,
        total_quests: deck_quest_number,
        required_tools: deck_quest_tools,
        tags: deck_tags,
      );

      Map<String, dynamic> deck_data = {
        "summary": new_summary,
        "quests": selected_deck?.quests ?? [],
      };

      // DEFINING THE HIVE BOX VAR
      Box box;

      // CHECKING IF THE BOX WAS PREVIOUSLY OPENED
      if (Hive.isBoxOpen(hive_box_name)) {

      // LOADING THE PREVIOUSLY OPENED INSTANCE
        box = Hive.box(hive_box_name);

      } else {

      // OPENING A NEW INSTANCE
        box = await Hive.openBox(hive_box_name);

      }

      // CHECKING IF THERE IS AN OLD VERSION OF THE DECK TO DELETE
      if (original_deck_key != null) {

        // DELETING THE OLD VERSION OF THE EDITED DECK
        await delete_custom_deck(original_deck_key);

      }

      // GETTING THE SAVED DECK KEY
      String saved_deck_key = deck_name;

      // INITIALIZING THE COUNTER
      int counter = 1;

      // COPYING THE DECK KEY IN TMP VAR
      String tmp_key = saved_deck_key;

      // CHECKING IF ALREADY EXIST A KEY WITH THE SAME NAME OF THE LOADED DECKS ONE
      while (box.containsKey(saved_deck_key)) {

        // UPDATING THE KEY NAME IN ORDER TO AVOID OVERWRITING
        saved_deck_key = '${counter}_$tmp_key';
        counter++;

      }

      // SAVING THE NEW DECK
      await box.put(saved_deck_key, deck_data);

      // RETURNING THE DECK KEY
      return saved_deck_key;

    } catch (e) {
      throw Exception("ERROR] - There was an error saving the deck: $e");
    }
  }

  //------------------------------------------------------------------------------

  // METHOD FOR SAVING A SINGLE QUEST
  static Future<void> save_quest({required DeckReader selected_deck, required Quest new_quest,}) async {
    try {
      selected_deck.quests.add(new_quest);

      await save_deck(
        deck_name: selected_deck.summary.name,
        deck_description: selected_deck.summary.description,
        deck_language: selected_deck.summary.language,
        couple_type: selected_deck.summary.couple_type,
        play_presence: selected_deck.summary.play_presence,
        deck_tags: selected_deck.summary.tags,
        selected_deck: selected_deck,
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
      if (result == null) return false;

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
      String deckKey = summary.name;

      // OPENING THE HIVE CONTAINER
      final box = await Hive.openBox('customDecks');

      // INITIALIZING THE COUNTER
      int counter = 1;

      // COPYING THE DECK KEY IN TMP VAR
      String tmp_key = deckKey;

      // CHECKING IF ALREADY EXIST A KEY WITH THE SAME NAME OF THE LOADED DECKS ONE
      while (box.containsKey(deckKey)) {

        // UPDATING THE KEY NAME IN ORDER TO AVOID OVERWRITING
        deckKey = '${counter}_$tmp_key';
        counter++;

      }

      // SAVING THE LOADED DECK IN THE HIVE APP DATABASE
      await box.put(deckKey, {
        'summary': summary,
        'quests': quests,
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
  Future<void> delete_legacy_custom_deck_file(String file_path) async {

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
      save_deck(deck_name: deck_object.summary.name, deck_description: deck_object.summary.description, deck_language: deck_object.summary.language, couple_type: deck_object.summary.couple_type, play_presence: deck_object.summary.play_presence, deck_tags: deck_object.summary.tags, legacy_selected_deck: deck_object);

      // DELETING THE LEGACY DECK
      delete_custom_deck(deck_object.deck_file_path);

    }

  }

  //------------------------------------------------------------------------------

}
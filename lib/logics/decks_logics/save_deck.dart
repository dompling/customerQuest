//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

// CUSTOM FILE
import 'package:loverquest/logics/decks_logics/quests_reader.dart';

//------------------------------------------------------------------------------



// DEFINING THE CLASS WHO WILL SAVE ON FILE A MODIFIED DECK
class DeckSaver {

  //------------------------------------------------------------------------------

  // FUNCTION TO CONVERT DATA IN A JSON DECK
  static Future<String> save_deck({ required String deck_name, required String deck_description, required String deck_language, required String couple_type, required bool play_distance, required List<String> deck_tags, DeckReader? selected_deck,}) async {

    try {

      //------------------------------------------------------------------------------

      // DEFINING THE QUEST NUMBER VAR
      int deck_quest_number = 0;

      // CHECKING IF THERE ARE QUEST INSIDE THE QUEST LIST
      if (selected_deck != null) {

        // ACQUIRING THE QUEST NUMBER
        deck_quest_number = selected_deck.quests.length;

      }

      //------------------------------------------------------------------------------

      // DEFINING THE QUEST TOOL LIST VAR
      List<String> deck_quest_tools = [];

      // CHECKING IF THERE ARE QUEST INSIDE THE QUEST LIST
      if (selected_deck != null && selected_deck.quests.isNotEmpty) {

        // ITERATING THE QUEST
        for (Quest current_quest in selected_deck.quests) {

          // CHECKING IF ALL THE QUEST TOOLS ARE NOT INSIDE THE DECK QUEST TOOLS LIST
          if (!(current_quest.required_tools.every((elements) => deck_quest_tools.contains(elements)))) {

            // ITERATING THE QUEST TOOLS
            for (String tool in current_quest.required_tools) {

              // CHECKING IF THE TOOL IS NOT ALREADY INSIDE THE DECK TOOL LIST
              if (!deck_quest_tools.contains(tool)) {

                // ADDING THE TOOL TO THE DECK LIST
                deck_quest_tools.add(tool);

              }

            }

          }

        }

      }

      //------------------------------------------------------------------------------

      // CREATING A NEW QUEST SUMMARY OBJECT WITH THE NEW INFORMATION
      QuestSummary new_summary = QuestSummary(
        name: deck_name,
        description: deck_description,
        couple_type: couple_type,
        play_distance: play_distance,
        language: deck_language,
        total_quests: deck_quest_number,
        required_tools: deck_quest_tools,
        tags: deck_tags,
      );

      //------------------------------------------------------------------------------

      // CREATING A NEW JSON FILE THE QUEST SUMMARY AND THE QUEST LIST (IF PRESENT)
      Map<String, dynamic> deck_data = {
        "summary": new_summary.toJson(),
        "quests": selected_deck?.quests.map((q) => q.toJson()).toList() ?? [],
      };

      //------------------------------------------------------------------------------

      // DEFINING THE FILE NAME AND PATH
      String file_path;
      if (selected_deck != null) {
        file_path = selected_deck.deck_file_path;
      } else {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        file_path = '${appDocDir.path}/custom_decks/$deck_name.json';
      }

      //------------------------------------------------------------------------------

      // WRITING THE JSON FILE
      File file = File(file_path);
      await file.writeAsString(jsonEncode(deck_data));

      //------------------------------------------------------------------------------

      // RETURNING THE SAVED FILE PATH
      return file_path;

      //------------------------------------------------------------------------------

    } catch (e) {

      // ERROR
      throw Exception("Errore nel salvataggio del deck: $e");

    }

  }

  //------------------------------------------------------------------------------

  // FUNCTION TO SAVE A NEW OR EDITED QUEST
  static Future<void> save_quest({
    required DeckReader selected_deck,
    required Quest new_quest,
  }) async {

    try {

      // ADDING THE QUEST TO THE DECK
      selected_deck.quests.add(new_quest);

      // SAVING THE NEW DECK
      await save_deck(
        deck_name: selected_deck.summary.name,
        deck_description: selected_deck.summary.description,
        deck_language: selected_deck.summary.language,
        couple_type: selected_deck.summary.couple_type,
        play_distance: selected_deck.summary.play_distance,
        deck_tags: selected_deck.summary.tags,
        selected_deck: selected_deck,
      );
    } catch (e) {
      throw Exception("[ERROR] - There was an error saving the quest: $e");
    }
  }

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------
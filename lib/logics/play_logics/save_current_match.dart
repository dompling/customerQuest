//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

//------------------------------------------------------------------------------

// CUSTOM FILES
import 'package:loverquest/logics/play_logics/player_class.dart';
import 'package:loverquest/logics/decks_logics/quests_reader.dart';

//------------------------------------------------------------------------------



// CLASS FOR SAVING AND LOADING THE MATCH STATUS ON TMP FILES
class GameStorage {

  //------------------------------------------------------------------------------

  // METHOD TO GET TMP FILE PATH
  static Future<File> get_file() async {

    // GETTING THE TMP FILE DIRECTORY
    final directory = await getApplicationDocumentsDirectory();

    // RETURNING THE FILE PATH
    return File('${directory.path}/match_data.json');

  }

  //------------------------------------------------------------------------------

  // METHOD TO SAVE ON THE SAME JSON FILE BOTH PLAYERS DATA AND ALL QUEST
  static Future<void> save_game_data(bool game_type, List<Players> players_list, List<Quest> early_quests_list, int early_quests_total_score, List<Quest> mid_quests_list, int mid_quests_total_score, List<Quest> late_quests_list, int late_quests_total_score, List<Quest> end_quests_list, int end_quests_total_score, int partial_score, Quest current_quest, List<Quest> current_quest_list) async {
    
    // GETTING THE TMP FILE PATH
    final file = await get_file();

    // DEFINING THE JSON STRUCTURE
    String jsonString = jsonEncode({
      'game_type': game_type,
      'players_list': players_list.map((p) => p.toJson()).toList(),
      'early_quests_list': early_quests_list.map((q) => q.toJson()).toList(),
      'mid_quests_list': mid_quests_list.map((q) => q.toJson()).toList(),
      'late_quests_list': late_quests_list.map((q) => q.toJson()).toList(),
      'end_quests_list': end_quests_list.map((q) => q.toJson()).toList(),
      'early_quests_total_score': early_quests_total_score,
      'mid_quests_total_score': mid_quests_total_score,
      'late_quests_total_score': late_quests_total_score,
      'end_quests_total_score': end_quests_total_score,
      'partial_score': partial_score,
      'current_quest': current_quest.toJson(),
      'current_quest_list': current_quest_list.map((q) => q.toJson()).toList(),

    });
    
    // WRITING THE DATA ON THE TMP FILE
    await file.writeAsString(jsonString);
    
  }

  //------------------------------------------------------------------------------

  // METHOD TO LOAD THE PLAYERS DATA AND QUESTS LIST FROM THE JSON TMP FILE
  static Future<Map<String, dynamic>> load_game_data() async {
    
    // CHECKING IF THE OPERATION WILL BE POSSIBLE
    try {
      
      //------------------------------------------------------------------------------
      
      // GETTING THE FILE PATH
      final file = await get_file();
      
      // WAITING TO GET THE FILE PATH IF THE FILE EXIST
      if (await file.exists()) {
        
        // CONVERTING THE FILE IN A STRING
        String content = await file.readAsString();
        
        // DECODING THE JSON STRING
        final Map<String, dynamic> jsonData = jsonDecode(content);
        
        // GETTING THE PLAYERS DATA OBJECT LIST
        List<Players> players_list = (jsonData['players_list'] as List)
            .map((p) => Players.fromJson(p))
            .toList();
        
        // GETTING THE EARLY QUESTS LIST
        List<Quest> early_quests_list = (jsonData['early_quests_list'] as List)
            .map((q) => Quest.fromJson(q))
            .toList();
        
        // GETTING THE MID QUESTS LIST
        List<Quest> mid_quests_list = (jsonData['mid_quests_list'] as List)
            .map((q) => Quest.fromJson(q))
            .toList();
        
        // GETTING THE LATE QUESTS LIST
        List<Quest> late_quests_list = (jsonData['late_quests_list'] as List)
            .map((q) => Quest.fromJson(q))
            .toList();
        
        // GETTING THE END QUESTS LIST
        List<Quest> end_quests_list = (jsonData['end_quests_list'] as List)
            .map((q) => Quest.fromJson(q))
            .toList();

        // GETTING THE CURRENT QUESTS LIST
        List<Quest> current_quest_list = (jsonData['current_quest_list'] as List)
            .map((q) => Quest.fromJson(q))
            .toList();

        // GETTING THE CURRENT QUEST
        Quest current_quest = Quest.fromJson(jsonData['current_quest']);

        // RETURNING THE LOADED VALUES
        return {
          'game_type': jsonData['game_type'] ?? true,
          'players_list': players_list,
          'early_quests_list': early_quests_list,
          'mid_quests_list': mid_quests_list,
          'late_quests_list': late_quests_list,
          'end_quests_list': end_quests_list,
          'early_quests_total_score': jsonData['early_quests_total_score'] ?? 0,
          'mid_quests_total_score': jsonData['mid_quests_total_score'] ?? 0,
          'late_quests_total_score': jsonData['late_quests_total_score'] ?? 0,
          'end_quests_total_score': jsonData['end_quests_total_score'] ?? 0,
          'partial_score': jsonData['partial_score'] ?? 0,
          'current_quest': current_quest,
          'current_quest_list': current_quest_list,
        };
        
      }
      
    } 
    
    // PRINTING AN ERROR STATEMENT
    catch (e) {
      //print("Errore nel caricamento dei dati: $e");
    }
    
    // RETURNING EMPTY VALUES
    return {
      'game_type': true,
      'players_list': [],
      'early_quests_list': [],
      'mid_quests_list': [],
      'late_quests_list': [],
      'end_quests_list': [],
      'partial_score': 0,
      'early_quests_total_score': 0,
      'mid_quests_total_score': 0,
      'late_quests_total_score': 0,
      'end_quests_total_score': 0,
      'current_quest': Quest.empty(),
      'current_quest_list': [],
    };
  }

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------
















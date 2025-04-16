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
  static Future<void> save_game_data(bool game_type, List<Players> players_list, Quest current_quest) async {
    
    // GETTING THE TMP FILE PATH
    final file = await get_file();

    // DEFINING THE JSON STRUCTURE
    String jsonString = jsonEncode({
      'game_type': game_type,
      'players_list': players_list.map((p) => p.toJson()).toList(),
      'current_quest': current_quest.toJson(),

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

        // GETTING THE CURRENT QUEST
        Quest current_quest = Quest.fromJson(jsonData['current_quest']);

        // RETURNING THE LOADED VALUES
        return {
          'game_type': jsonData['game_type'] ?? true,
          'players_list': players_list,
          'current_quest': current_quest,
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
      'current_quest': Quest.empty(),
    };
  }

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------
















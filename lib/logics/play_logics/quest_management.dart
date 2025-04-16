//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:math';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/quests_reader.dart';
import  'package:loverquest/logics/play_logics/player_class.dart';



//------------------------------------------------------------------------------



// FUNCTION THAT WILL FILTER A QUEST LIST BY PLAYER SEX
List<Quest> filter_quest_list_by_sex (Players player, List<Quest> quest_list) {

  // INITIALIZING THE FILTERED QUEST LIST
  List<Quest> filtered_quest_list = [];

   // CHECKING IF THE PLAYER IS FEMALE
  if (player.player_sex == true) {

    // ITERATING THE QUEST LIST
    for (Quest quest in quest_list) {

      // CHECKING IF THE QUEST IS SUITABLE FOR THE PLAYER
      if (quest.player_type == "both" || quest.player_type == "female") {

        // ADDING THE QUEST TO THE FILTERED QUEST LIST
        filtered_quest_list.add(quest);

      }

    }

  } else {

    // ITERATING THE QUEST LIST
    for (Quest quest in quest_list) {

      // CHECKING IF THE QUEST IS SUITABLE FOR THE PLAYER
      if (quest.player_type == "both" || quest.player_type == "male") {

        // ADDING THE QUEST TO THE FILTERED QUEST LIST
        filtered_quest_list.add(quest);

      }

    }

  }

  // RETURNING THE FILTERED QUEST LIST
  return filtered_quest_list;

}



//------------------------------------------------------------------------------



// FUNCTION THAT WILL SELECT A RANDOM QUEST FROM A GIVEN QUEST LIST
Quest select_random_quest (List<Quest> quest_list) {

  //------------------------------------------------------------------------------

  // CREATING RANDOM INSTANCE
  var random = Random();

  //------------------------------------------------------------------------------

  // GETTING LIST LENGTH
  int list_size = quest_list.length;

  //------------------------------------------------------------------------------

  // GENERATING RANDOM NUMBER BETWEEN 0-LIST LENGTH
  int random_number = random.nextInt(list_size);

  //------------------------------------------------------------------------------

  // GETTING THE QUEST
  Quest current_quest = quest_list[random_number];

  //------------------------------------------------------------------------------

  // RETURNING THE SELECTED QUEST
  return current_quest;

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------



// FUNCTION THAT WILL REMOVE FROM THE LIST THE SKIPPED OR DONE QUEST
List<Quest> remove_skipped_done_quests (List<Quest> quest_list, current_quest) {

  //------------------------------------------------------------------------------

  // REMOVING THE DONE/SKIPPED QUEST FROM THE LIST
  quest_list.remove(current_quest);

  //------------------------------------------------------------------------------

  // RETURNING BACK THE LIST
  return quest_list;

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------



// FUNCTION FOR GETTING THE CURRENT QUEST LIST TYPE
List<Quest> get_current_quest_list (Quest current_quest, List<Quest> early_quests_list, List<Quest> mid_quests_list, List<Quest> late_quests_list, List<Quest> end_quests_list) {
  
  // CHECKING WHICH QUEST MOMENT IS CURRENTLY IN USE
  if (current_quest.moment == "early") {
    
    // RETURNING THE CORRECT LIST ACTUALLY IN USE
    return early_quests_list;
    
  } else if (current_quest.moment == "mid") {

    // RETURNING THE CORRECT LIST ACTUALLY IN USE
    return mid_quests_list;
    
  } else if (current_quest.moment == "late") {

    // RETURNING THE CORRECT LIST ACTUALLY IN USE
    return late_quests_list;
    
  }

  // RETURNING THE CORRECT LIST ACTUALLY IN USE
  return end_quests_list;
  
}



//------------------------------------------------------------------------------



// FUNCTION FOR GETTING THE NEXT QUEST LIST
void switch_next_quest_list (Players player, Quest current_quest) {

  // CHECKING WHICH QUEST MOMENT IS CURRENTLY IN USE
  if (current_quest.moment == "early") {

    // SETTING THE CORRECT LIST ACTUALLY IN USE
    player.player_current_quest_list = player.player_mid_quest_list;

    // SETTING THE CORRECT LIST COUNTER ACTUALLY IN USE
    player.player_current_quest_list_counter = player.player_mid_quest_list_counter;

  } else if (current_quest.moment == "mid") {

    // SETTING THE CORRECT LIST ACTUALLY IN USE
    player.player_current_quest_list = player.player_late_quest_list;

    // SETTING THE CORRECT LIST COUNTER ACTUALLY IN USE
    player.player_current_quest_list_counter = player.player_late_quest_list_counter;

  } else {

    // SETTING THE CORRECT LIST ACTUALLY IN USE
    player.player_current_quest_list = player.player_end_quest_list;

    // SETTING THE CORRECT LIST COUNTER ACTUALLY IN USE
    player.player_current_quest_list_counter = player.player_end_quest_list_counter;
  }

}



//------------------------------------------------------------------------------
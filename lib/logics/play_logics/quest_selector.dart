//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:math';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/quests_reader.dart';

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



// FUNCTION THAT WILL CHECK WHICH QUEST LIST THE APP SHOULD USE
List<Quest> quest_list_switch (Quest current_quest, int partial_score, List<Quest> early_quests_list, int early_quests_total_score, List<Quest> mid_quests_list, int mid_quests_total_score, List<Quest> late_quests_list, int late_quests_total_score, List<Quest> end_quests_list, int end_quests_total_score,) {
  
  // CHECKING WHICH QUEST LIST IS IN USE
  if (current_quest.moment == "early") {

    // CHECKING IF THE PARTIAL SCORE CLAUSE IS PASSED
    if ((partial_score > (early_quests_total_score/3)*2) || early_quests_list.isEmpty) {

      // SETTING THE NEXT QUEST LIST
      return mid_quests_list;

    } else {return early_quests_list;}

  } else if (current_quest.moment == "mid") {

    // CHECKING IF THE PARTIAL SCORE CLAUSE IS PASSED
    if ((partial_score > (mid_quests_total_score/3)*2) || mid_quests_list.isEmpty) {

      // SETTING THE NEXT QUEST LIST
      return late_quests_list;

    } else {return mid_quests_list;}

  } else if (current_quest.moment == "late") {

    // CHECKING IF THE PARTIAL SCORE CLAUSE IS PASSED
    if ((partial_score > (late_quests_total_score/3)*2) || late_quests_list.isEmpty) {

      // SETTING THE NEXT QUEST LIST
      return end_quests_list;

    } else {return late_quests_list;}

  }

  // SETTING THE NEXT QUEST LIST
  return end_quests_list;
  
}



//------------------------------------------------------------------------------
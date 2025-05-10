//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:math';

// CUSTOM FILES
import 'package:loverquest/logics/play_logics/01_match_data_class.dart';
import 'package:loverquest/logics/play_logics/02_players_class.dart';

import 'package:loverquest/logics/decks_logics/03_quest_class.dart';

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

// FUNCTION THAT WILL LOAD THE PLAYERS PERSONAL QUEST LISTS
MatchData load_players_quest_lists (MatchData match_data) {

  // GETTING THE PLAYER 1 QUEST LISTS AND COUNTERS
  match_data.player_one.player_early_quest_list = filter_quest_list_by_sex(match_data.player_one,match_data.deck_early_quest_list);
  match_data.player_one.player_early_quest_list_counter = match_data.player_one.player_early_quest_list.length;
  match_data.player_one.player_mid_quest_list = filter_quest_list_by_sex(match_data.player_one,match_data.deck_mid_quest_list);
  match_data.player_one.player_mid_quest_list_counter = match_data.player_one.player_mid_quest_list.length;
  match_data.player_one.player_late_quest_list = filter_quest_list_by_sex(match_data.player_one,match_data.deck_late_quest_list);
  match_data.player_one.player_late_quest_list_counter = match_data.player_one.player_late_quest_list.length;
  match_data.player_one.player_end_quest_list = filter_quest_list_by_sex(match_data.player_one,match_data.deck_end_quest_list);
  match_data.player_one.player_end_quest_list_counter = match_data.player_one.player_end_quest_list.length;

  // GETTING THE PLAYER 2 QUEST LISTS
  match_data.player_two.player_early_quest_list = filter_quest_list_by_sex(match_data.player_two,match_data.deck_early_quest_list);
  match_data.player_two.player_early_quest_list_counter = match_data.player_two.player_early_quest_list.length;
  match_data.player_two.player_mid_quest_list = filter_quest_list_by_sex(match_data.player_two,match_data.deck_mid_quest_list);
  match_data.player_two.player_mid_quest_list_counter = match_data.player_two.player_mid_quest_list.length;
  match_data.player_two.player_late_quest_list = filter_quest_list_by_sex(match_data.player_two,match_data.deck_late_quest_list);
  match_data. player_two.player_late_quest_list_counter = match_data.player_two.player_late_quest_list.length;
  match_data.player_two.player_end_quest_list = filter_quest_list_by_sex(match_data.player_two,match_data.deck_end_quest_list);
  match_data.player_two.player_end_quest_list_counter = match_data.player_two.player_end_quest_list.length;

  // RETURNING THE MATCH DATA OBJECT
  return match_data;
  
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

// FUNCTION FOR GETTING THE NEXT QUEST LIST
MatchData switch_next_quest_list (MatchData match_data) {

  // CHECKING WHICH QUEST MOMENT IS CURRENTLY IN USE
  if (match_data.current_quest.moment == "early") {

    // SETTING THE CORRECT LIST ACTUALLY IN USE
    match_data.player_one.player_current_quest_list = match_data.player_one.player_mid_quest_list;

    // SETTING THE CORRECT LIST COUNTER ACTUALLY IN USE
    match_data.player_one.player_current_quest_list_counter = match_data.player_one.player_mid_quest_list_counter;

    // SETTING THE CORRECT LIST ACTUALLY IN USE
    match_data.player_two.player_current_quest_list = match_data.player_two.player_mid_quest_list;

    // SETTING THE CORRECT LIST COUNTER ACTUALLY IN USE
    match_data.player_two.player_current_quest_list_counter = match_data.player_two.player_mid_quest_list_counter;

    // RETURNING THE MATCH DATA OBJECT
    return match_data;

  } else if (match_data.current_quest.moment == "mid") {

    // SETTING THE CORRECT LIST ACTUALLY IN USE
    match_data.player_one.player_current_quest_list = match_data.player_one.player_late_quest_list;

    // SETTING THE CORRECT LIST COUNTER ACTUALLY IN USE
    match_data.player_one.player_current_quest_list_counter = match_data.player_one.player_late_quest_list_counter;

    // SETTING THE CORRECT LIST ACTUALLY IN USE
    match_data.player_two.player_current_quest_list = match_data.player_two.player_late_quest_list;

    // SETTING THE CORRECT LIST COUNTER ACTUALLY IN USE
    match_data.player_two.player_current_quest_list_counter = match_data.player_two.player_late_quest_list_counter;

    // RETURNING THE MATCH DATA OBJECT
    return match_data;

  }

  // SETTING THE CORRECT LIST ACTUALLY IN USE
  match_data.player_one.player_current_quest_list = match_data.player_one.player_end_quest_list;

  // SETTING THE CORRECT LIST COUNTER ACTUALLY IN USE
  match_data.player_one.player_current_quest_list_counter = match_data.player_one.player_end_quest_list_counter;

  // SETTING THE CORRECT LIST ACTUALLY IN USE
  match_data.player_two.player_current_quest_list = match_data.player_two.player_end_quest_list;

  // SETTING THE CORRECT LIST COUNTER ACTUALLY IN USE
  match_data.player_two.player_current_quest_list_counter = match_data.player_two.player_end_quest_list_counter;

  // RETURNING THE MATCH DATA OBJECT
  return match_data;


}

//------------------------------------------------------------------------------

// CHECKING WHICH QUEST TYPE WILL BE THE END QUEST TYPE
String getting_end_quest_type (MatchData match_data) {

  if (match_data.player_one.player_end_quest_list.isNotEmpty || match_data.player_two.player_end_quest_list.isNotEmpty) {

    // RETURNING THE END QUEST TYPE TO AIM
    return "end";

  } else if (match_data.player_one.player_late_quest_list.isNotEmpty || match_data.player_two.player_late_quest_list.isNotEmpty) {

    // RETURNING THE END QUEST TYPE TO AIM
    return "late";

  } else if (match_data.player_one.player_mid_quest_list.isNotEmpty || match_data.player_two.player_mid_quest_list.isNotEmpty) {

    // RETURNING THE END QUEST TYPE TO AIM
    return "mid";

  } else {

    // RETURNING THE END QUEST TYPE TO AIM
    return "early";

  }

}

//------------------------------------------------------------------------------

// CHECKING WHICH QUEST TYPE WILL BE THE START QUEST TYPE
Players getting_start_quest_type (MatchData match_data, Players player_to_set) {

  if (match_data.player_one.player_early_quest_list.isNotEmpty || match_data.player_two.player_early_quest_list.isNotEmpty) {

    // SETTING THE CURRENT LIST AND CURRENT LIST COUNTER
    player_to_set.player_current_quest_list = player_to_set.player_early_quest_list;
    player_to_set.player_current_quest_list_counter = player_to_set.player_early_quest_list_counter;

    // RETURNING THE UPDATED PLAYER DATA
    return player_to_set;

  } else if (match_data.player_one.player_mid_quest_list.isNotEmpty || match_data.player_two.player_mid_quest_list.isNotEmpty) {

    // SETTING THE CURRENT LIST AND CURRENT LIST COUNTER
    player_to_set.player_current_quest_list = player_to_set.player_mid_quest_list;
    player_to_set.player_current_quest_list_counter = player_to_set.player_mid_quest_list_counter;

    // RETURNING THE UPDATED PLAYER DATA
    return player_to_set;

  } else if (match_data.player_one.player_late_quest_list.isNotEmpty || match_data.player_two.player_late_quest_list.isNotEmpty) {

    // SETTING THE CURRENT LIST AND CURRENT LIST COUNTER
    player_to_set.player_current_quest_list = player_to_set.player_late_quest_list;
    player_to_set.player_current_quest_list_counter = player_to_set.player_late_quest_list_counter;

    // RETURNING THE UPDATED PLAYER DATA
    return player_to_set;

  }

  // SETTING THE CURRENT LIST AND CURRENT LIST COUNTER
  player_to_set.player_current_quest_list = player_to_set.player_end_quest_list;
  player_to_set.player_current_quest_list_counter = player_to_set.player_end_quest_list_counter;

  // RETURNING THE UPDATED PLAYER DATA
  return player_to_set;

}

//------------------------------------------------------------------------------
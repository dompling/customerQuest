//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:math';

// CUSTOM FILES
import 'package:loverquest/logics/play_logics/player_class.dart';
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
  Quest selected_quest = quest_list[random_number];

  //------------------------------------------------------------------------------

  // RETURNING THE SELECTED QUEST
  return selected_quest;

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------



// FUNCTION THAT WILL REMOVE FROM THE LIST THE SKIPPED OR DONE QUEST
List<Quest> remove_skipped_done_quests (List<Quest> quest_list, selected_quest) {

  //------------------------------------------------------------------------------

  // REMOVING THE DONE/SKIPPED QUEST FROM THE LIST
  quest_list.remove(selected_quest);

  //------------------------------------------------------------------------------

  // RETURNING BACK THE LIST
  return quest_list;

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------













//------------------------------------------------------------------------------
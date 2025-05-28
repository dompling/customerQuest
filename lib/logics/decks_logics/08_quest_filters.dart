//------------------------------------------------------------------------------

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';

//------------------------------------------------------------------------------

// POSSIBLE SORTING TYPE:
// ascending      | THE QUESTS WILL BE SORTED IN AN ASCENDING ORDER EARLY --> END
// descending     | THE QUESTS WILL BE SORTED IN AN DESCENDING ORDER END --> EARLY

// POSSIBLE MOMENT FILTERS TYPE:
// all            | WILL BE SHOWN ALL THE QUEST
// only_early     | WILL BE SHOWN ONLY THE QUEST WITH MOMENT = EARLY
// only_mid       | WILL BE SHOWN ONLY THE QUEST WITH MOMENT = MID
// only_late      | WILL BE SHOWN ONLY THE QUEST WITH MOMENT = LATE
// only end       | WILL BE SHOWN ONLY THE QUEST WITH MOMENT = END

// POSSIBLE TOOLS FILTER TYPE:
// all            | WILL BE SHOWN ALL THE QUEST
// with_tools     | WILL BE SHOWN ONLY THE QUEST WITH TOOLS
// without_tools  | WILL BE SHOWN ONLY THE QUEST WITHOUT TOOLS

//------------------------------------------------------------------------------

// INITIAL STATE FUNCTION TO LOAD ALL DEFAULTS DECKS
Future<List<Quest>> quest_filter_sorting (DeckReader deck, {String? sorting_type = "ascending", String? moment_filter = "all", String? tools_filter = "all"}) async {

  // INITIALIZING QUEST LISTS
  List<Quest> early_quests_list = [];
  List<Quest> mid_quests_list = [];
  List<Quest> late_quests_list = [];
  List<Quest> end_quests_list = [];

  // ACQUIRING THE CORRECT QUESTS FOR EVERY LIST
  for (Quest quest in deck.quests) {

    if (quest.moment == "early") {

      // FILTERING FOR QUEST TOOLS
      if (tools_filter != null && tools_filter == "with_tools") {

        // ADDING THE QUEST TO THE LIST
        early_quests_list.add(quest);

      } else if (tools_filter != null && tools_filter == "without_tools") {

        // ADDING THE QUEST TO THE LIST
        early_quests_list.add(quest);

      } else {

        // ADDING THE QUEST TO THE LIST
        early_quests_list.add(quest);

      }

    } else if (quest.moment == "mid") {

      // FILTERING FOR QUEST TOOLS
      if (tools_filter != null && tools_filter == "with_tools") {

        // ADDING THE QUEST TO THE LIST
        mid_quests_list.add(quest);

      } else if (tools_filter != null && tools_filter == "without_tools") {

        // ADDING THE QUEST TO THE LIST
        mid_quests_list.add(quest);

      } else {

        // ADDING THE QUEST TO THE LIST
        mid_quests_list.add(quest);
      }


    } else if (quest.moment == "late") {

      // FILTERING FOR QUEST TOOLS
      if (tools_filter != null && tools_filter == "with_tools") {

        // ADDING THE QUEST TO THE LIST
        late_quests_list.add(quest);

      } else if (tools_filter != null && tools_filter == "without_tools") {

        // ADDING THE QUEST TO THE LIST
        late_quests_list.add(quest);

      } else {

        // ADDING THE QUEST TO THE LIST
        late_quests_list.add(quest);
      }


    } else {

      // FILTERING FOR QUEST TOOLS
      if (tools_filter != null && tools_filter == "with_tools") {

        // ADDING THE QUEST TO THE LIST
        end_quests_list.add(quest);

      } else if (tools_filter != null && tools_filter == "without_tools") {

        // ADDING THE QUEST TO THE LIST
        end_quests_list.add(quest);

      } else {

        // ADDING THE QUEST TO THE LIST
        end_quests_list.add(quest);
      }

    }

  }


  // SETTING THE CORRECT FILTERED DECK
  if (moment_filter == null || moment_filter == "all") {

    if (sorting_type == null || sorting_type == "ascending") {

      // RETURNING THE FILTERED LIST
      return early_quests_list + mid_quests_list + late_quests_list + end_quests_list;

    } else {

      // RETURNING THE FILTERED LIST
      return end_quests_list + late_quests_list + mid_quests_list + early_quests_list;

    }

  } else if (moment_filter == "only_early") {

    // RETURNING THE FILTERED LIST
    return early_quests_list;

  } else if (moment_filter == "only_mid") {

    // RETURNING THE FILTERED LIST
    return mid_quests_list;

  } else if (moment_filter == "only_late") {

    // RETURNING THE FILTERED LIST
    return late_quests_list;

  } else {

    // RETURNING THE FILTERED LIST
    return end_quests_list;

  }

}
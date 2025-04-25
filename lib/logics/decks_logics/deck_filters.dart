//------------------------------------------------------------------------------

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/deck_and_quests_reader.dart';

bool containsAny(List<String> list1, List<String> list2) {
  return list2.any((element) => list1.contains(element));
}

//------------------------------------------------------------------------------



// FILTERING DECK LIST FOR COUPLE TYPE
List<DeckReader> filter_decks_for_couple_type (List<DeckReader> loaded_decks_list, String selected_couple_type) {

  //------------------------------------------------------------------------------

  // INITIALIZING FILTERED LIST
  List<DeckReader> filtered_list = [];

  //------------------------------------------------------------------------------

  // ITERATING THE LOADED DECK LIST
  for (DeckReader loaded_deck in loaded_decks_list) {

    // CHECKING IF THE DECK COUPLE IS COMPATIBLE WITH THE ONE SELECTED
    if (loaded_deck.summary.couple_type == selected_couple_type) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    }

  }

  //------------------------------------------------------------------------------

  // RETURNING THE FILTERED DECKS LIST
  return filtered_list;

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------



// FILTERING DECK LIST FOR PRESENCE - DISTANCE
List<DeckReader> filter_decks_for_presence_distance (List<DeckReader> loaded_decks_list, bool play_presence) {

  //------------------------------------------------------------------------------

  // INITIALIZING FILTERED LIST
  List<DeckReader> filtered_list = [];

  //------------------------------------------------------------------------------

  // ITERATING THE LOADED DECK LIST
  for (DeckReader loaded_deck in loaded_decks_list) {

    // CHECKING IF THE DECK COUPLE IS COMPATIBLE WITH THE ONE SELECTED
    if (loaded_deck.summary.play_presence == play_presence) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    }

  }

  //------------------------------------------------------------------------------

  // RETURNING THE FILTERED DECKS LIST
  return filtered_list;

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------



// FILTERING DECK LIST FOR WANTED TOOLS
List<DeckReader> filter_decks_for_excluded_tools_presence (List<DeckReader> loaded_decks_list,  List<String> wanted_tools_list) {

  //------------------------------------------------------------------------------

  // INITIALIZING FILTERED LIST
  List<DeckReader> filtered_list = [];

  //------------------------------------------------------------------------------

  // ITERATING THE LOADED DECK LIST
  for (DeckReader loaded_deck in loaded_decks_list) {

    // CHECKING IF ANY TOOL FROM THE EXCLUDED TOOLS LIST IS CONTAINED INSIDE THE DECK REQUIRED LIST
    bool contains_excluded_tools = containsAny(loaded_deck.summary.required_tools, wanted_tools_list);

    if (!contains_excluded_tools) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    }

  }

  //------------------------------------------------------------------------------

  // RETURNING THE FILTERED DECKS LIST
  return filtered_list;

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------



//
List<DeckReader> filter_decks_for_couple_type_and_game_type (List<DeckReader> loaded_decks_list, String couple_type, bool game_type) {

  //------------------------------------------------------------------------------

  // INITIALIZING FILTERED LIST
  List<DeckReader> filtered_list = [];

  //------------------------------------------------------------------------------

  // ITERATING THE LOADED DECK LIST
  for (DeckReader loaded_deck in loaded_decks_list) {

    // CHECKING IF THE DECK COUPLE TYPE MATCH THE SELECTED ONE
    if ((loaded_deck.summary.couple_type.toLowerCase() == couple_type.toLowerCase()) && (loaded_deck.summary.play_presence == game_type)) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    }

  }

  //------------------------------------------------------------------------------

  // RETURNING THE FILTERED DECKS LIST
  return filtered_list;

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------
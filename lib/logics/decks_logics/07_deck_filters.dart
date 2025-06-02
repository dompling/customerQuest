//------------------------------------------------------------------------------

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';

bool containsAny(List<String> list1, List<String> list2) {
  return list2.any((element) => list1.contains(element));
}

//------------------------------------------------------------------------------

// FILTERING DECK LIST FOR COUPLE TYPE
List<DeckReader> filter_decks_for_couple_type (List<DeckReader> loaded_decks_list, String selected_couple_type) {

  // INITIALIZING FILTERED LIST
  List<DeckReader> filtered_list = [];

  // ITERATING THE LOADED DECK LIST
  for (DeckReader loaded_deck in loaded_decks_list) {

    // CHECKING IF THE DECK COUPLE IS COMPATIBLE WITH THE ONE SELECTED
    if (loaded_deck.summary.couple_type == selected_couple_type) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    }

  }

  // RETURNING THE FILTERED DECKS LIST
  return filtered_list;

}

//------------------------------------------------------------------------------

// FILTERING DECK LIST FOR PRESENCE - DISTANCE
List<DeckReader> filter_decks_for_presence_distance (List<DeckReader> loaded_decks_list, bool play_presence) {

  // INITIALIZING FILTERED LIST
  List<DeckReader> filtered_list = [];

  // ITERATING THE LOADED DECK LIST
  for (DeckReader loaded_deck in loaded_decks_list) {

    // CHECKING IF THE DECK COUPLE IS COMPATIBLE WITH THE ONE SELECTED
    if (loaded_deck.summary.play_presence == play_presence) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    }

  }

  // RETURNING THE FILTERED DECKS LIST
  return filtered_list;

}

//------------------------------------------------------------------------------

// FILTERING DECK LIST FOR TOOLS PRESENCE
List<DeckReader> filter_decks_for_tools_presence (List<DeckReader> loaded_decks_list, bool tools_presence) {

  // INITIALIZING FILTERED LIST
  List<DeckReader> filtered_list = [];

  // ITERATING THE LOADED DECK LIST
  for (DeckReader loaded_deck in loaded_decks_list) {

    // CHECKING IF THE DECK COUPLE IS COMPATIBLE WITH THE ONE SELECTED
    if (loaded_deck.summary.required_tools.isNotEmpty && tools_presence == true) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    } else if (loaded_deck.summary.required_tools.isEmpty && tools_presence == false) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    }

  }

  // RETURNING THE FILTERED DECKS LIST
  return filtered_list;

}

//------------------------------------------------------------------------------

// FILTERING DECK LIST FOR CHAT PRESENCE
List<DeckReader> filter_decks_for_chat_presence (List<DeckReader> loaded_decks_list, bool chat_presence) {

  // INITIALIZING FILTERED LIST
  List<DeckReader> filtered_list = [];

  // ITERATING THE LOADED DECK LIST
  for (DeckReader loaded_deck in loaded_decks_list) {

    // CHECKING IF THE DECK COUPLE IS COMPATIBLE WITH THE ONE SELECTED
    if (loaded_deck.summary.tags.contains('chat') && chat_presence == true) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    } else if (loaded_deck.summary.tags.contains('video_call') && chat_presence == false) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    }

  }

  // RETURNING THE FILTERED DECKS LIST
  return filtered_list;

}

//------------------------------------------------------------------------------

// FILTERING DECK LIST FOR CHAT PRESENCE
List<DeckReader> filter_decks_for_difficulty (List<DeckReader> loaded_decks_list, bool chat_presence) {

  // INITIALIZING FILTERED LIST
  List<DeckReader> filtered_list = [];

  // ITERATING THE LOADED DECK LIST
  for (DeckReader loaded_deck in loaded_decks_list) {

    // CHECKING IF THE DECK COUPLE IS COMPATIBLE WITH THE ONE SELECTED
    if (loaded_deck.summary.tags.contains('chat') && chat_presence == true) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    } else if (loaded_deck.summary.required_tools.contains('video_call') && chat_presence == false) {

      // ADDING THE DECK TO THE FILTERED LIST
      filtered_list.add(loaded_deck);

    }

  }

  // RETURNING THE FILTERED DECKS LIST
  return filtered_list;

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
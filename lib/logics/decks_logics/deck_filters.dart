//------------------------------------------------------------------------------

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/quests_reader.dart';

//------------------------------------------------------------------------------



//------------------------------------------------------------------------------
List<DeckReader> filter_decks_for_couple_type_and_game_type (List<DeckReader> loaded_decks_list, String couple_type, bool game_type) {

  //------------------------------------------------------------------------------

  // INITIALIZING FILTERED LIST
  List<DeckReader> filtered_list = [];

  //------------------------------------------------------------------------------

  // ITERATING THE LOADED DECK LIST
  for (DeckReader loaded_deck in loaded_decks_list) {

    // CHECKING IF THE DECK COUPLE TYPE MATCH THE SELECTED ONE
    if ((loaded_deck.summary.couple_type.toLowerCase() == couple_type.toLowerCase()) && (loaded_deck.summary.play_distance == game_type)) {

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
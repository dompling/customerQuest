//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'package:flutter/material.dart';

// CUSTOM LIBRARIES
import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';

//------------------------------------------------------------------------------


// WRAPPER CLASS FOR OBJECT EXCHANGE INSIDE DECKS PAGES
class DeckPagesWrapper {

  // CLASS ATTRIBUTES
  bool? load_default_decks_flag;
  bool? new_deck_creation;
  DeckReader? selected_deck;
  Quest? selected_quest;
  bool? show_delete_button;

  // CLASS CONSTRUCTOR
  DeckPagesWrapper({

    this.load_default_decks_flag = false,
    this.new_deck_creation = false,
    this.selected_deck,
    this.selected_quest,
    this.show_delete_button = false

  });

}

// DECK WRAPPER DATA CLASS FOR PROVIDER SAVING
class DeckWrapperProvider extends ChangeNotifier {

  // CLASS ATTRIBUTES
  DeckPagesWrapper? _wrapperData;

  // WRAPPER GETTER FUNCTION
  DeckPagesWrapper? get wrapperData => _wrapperData;

  // FUNCTION TO UPDATE THE WRAPPER DATA
  void updateWrapperData(DeckPagesWrapper? newData) {
    _wrapperData = newData;
    notifyListeners();
  }
}











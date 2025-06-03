//------------------------------------------------------------------------------
// Loverquest - https://github.com/H3rz3n/loverquest/
//
// Copyright (C) 2025 Lorenzo Maiuri & Contributors
//
// This file is part of Loverquest.
//
// Loverquest is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Loverquest is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Loverquest.  If not, see <https://www.gnu.org/licenses/>.
//
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

//------------------------------------------------------------------------------

// WRAPPER CLASS FOR OBJECT EXCHANGE INSIDE DECKS PAGES
class PlayPagePopUpWrapper {

  // CLASS ATTRIBUTES
  bool session_check;

  // CLASS CONSTRUCTOR
  PlayPagePopUpWrapper({

    this.session_check = false,

  });

}

// DECK WRAPPER DATA CLASS FOR PROVIDER SAVING
class PlayPagePopUpWrapperProvider extends ChangeNotifier {

  // CLASS ATTRIBUTES
  PlayPagePopUpWrapper? _wrapperData;

  // WRAPPER GETTER FUNCTION
  PlayPagePopUpWrapper? get wrapperData => _wrapperData;

  // FUNCTION TO UPDATE THE WRAPPER DATA
  void updateWrapperData(PlayPagePopUpWrapper? newData) {
    _wrapperData = newData;
    notifyListeners();
  }
}






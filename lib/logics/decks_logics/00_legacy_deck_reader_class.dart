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
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/02_deck_summary_class.dart';
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';

//------------------------------------------------------------------------------



// DEFAULT DECK MANAGER CLASS
class LegacyDeckReader {

  //------------------------------------------------------------------------------

  // QUEST MANAGER ATTRIBUTES
  DeckSummary summary = DeckSummary(
      name: "Unknown title",
      description: "No description, sorry",
      couple_type: "lesbian",
      play_presence: false,
      language: "en",
      total_quests: 0,
      required_tools: [],
      tags: []
  );

  // CLASS ATTRIBUTES
  List<Quest> quests = [];
  final String deck_file_path;

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  LegacyDeckReader (this.deck_file_path);

  //------------------------------------------------------------------------------

  // LOADING JSON FROM ASSETS AND CONVERTING IT IN OBJECTS METHOD
  Future<void> load_legacy_deck() async {

    try {

      //
      String jsonString;

      // CHECKING IF THE FILE IS FROM THE CUSTOM FOLDER OR FROM THE ASSETS
      if (deck_file_path.contains('assets/')) {

        // LOADING JSON AS STRING WITH ROOT BUNDLE
        jsonString = await rootBundle.loadString(deck_file_path);

      } else {

        // LOADING JSON AS STRING WITH FILE PATH
        File file = File(deck_file_path);
        jsonString = await file.readAsString();

      }

      // DECODING JSON FILE
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // ACQUIRING DECKS SUMMARY
      summary = DeckSummary.fromJson(jsonData['summary']);

      // ACQUIRING DECKS QUESTS
      quests =
          (jsonData['quests'] as List).map((q) => Quest.fromJson(q)).toList();

    } catch (e) {
      quests = [];
    }

  }

//------------------------------------------------------------------------------

}

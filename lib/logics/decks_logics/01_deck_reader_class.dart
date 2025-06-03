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
import 'package:flutter/services.dart';

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/02_deck_summary_class.dart';
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';

// HIVE
import 'package:hive_flutter/hive_flutter.dart';

// SETTING THE GENERATION OF G.DART FILE
part '01_deck_reader_class.g.dart';

// SETTING THE HIVE STORAGE ID
@HiveType(typeId: 4)

//------------------------------------------------------------------------------

// DEFAULT DECK MANAGER CLASS
class DeckReader {

  //------------------------------------------------------------------------------

  // QUEST MANAGER ATTRIBUTES
  @HiveField(0)
  DeckSummary summary;

  @HiveField(1)
  List<Quest> quests;

  @HiveField(2)
  final String deck_key;

  // DEFAULT CLASS CONSTRUCTOR
  DeckReader(this.deck_key)
      : summary = DeckSummary(
    name: "Unknown title",
    description: "No description, sorry",
    couple_type: "lesbian",
    play_presence: false,
    language: "en",
    total_quests: 0,
    required_tools: [],
    tags: [],
  ),
        quests = [];

  // EMPTY CLASS CONSTRUCTOR
  DeckReader.empty()
      : summary = DeckSummary(
    name: "Unknown title",
    description: "No description, sorry",
    couple_type: "lesbian",
    play_presence: false,
    language: "en",
    total_quests: 0,
    required_tools: [],
    tags: [],
  ),
        quests = [],
        deck_key = "unknown_path";

  //------------------------------------------------------------------------------

  // LOADING JSON FROM ASSETS AND CONVERTING IT IN OBJECTS METHOD
  Future<void> load_deck() async {

    try {
      
      // DEFINING THE JSON STRING VAR
      String json_string;

      // CHECKING IF THE FILE IS FROM THE CUSTOM FOLDER OR FROM THE ASSETS
      if (deck_key.contains('assets/')) {

        // THE FILE IS FROM THE ASSETS

        // LOADING JSON AS STRING WITH ROOT BUNDLE
        json_string = await rootBundle.loadString(deck_key);

        // DECODING JSON FILE
        final Map<String, dynamic> jsonData = json.decode(json_string);

        // ACQUIRING DECKS SUMMARY
        summary = DeckSummary.fromJson(jsonData['summary']);

        // ACQUIRING DECKS QUESTS
        quests = (jsonData['quests'] as List).map((q) => Quest.fromJson(q)).toList();

      } else {

        // THE FILE IS FROM THE CUSTOM DECKS

        // OPENING THE HIVE BOX
        var box = await Hive.openBox('customDecks');
        Map? data = box.get(deck_key);

        // CHECKING THAT THE DATA EXIST
        if (data != null) {

          // LOADING THE DECK SUMMARY
          summary = data['summary'] as DeckSummary;

          // LOADING THE QUESTS LIST
          quests = List<Quest>.from(data['quests']);

        } else {

          // LOADING THE DEFAULT DECK SUMMARY VALUES
          summary = DeckSummary(
            name: "Error",
            description: "This deck does not exist",
            couple_type: "hetero",
            play_presence: false,
            language: "en",
            total_quests: 0,
            required_tools: [],
            tags: [],
          );

          // LOADING THE DEFAULT QUESTS LIST
          quests = [];

        }

      }

    } catch (e) {
      quests = [];
    }

  }

  //------------------------------------------------------------------------------

  // FROM OBJECT TO JSON CONVERSION METHOD
  Map<String, dynamic> toJson() {
    return {
      'summary': summary.toJson(),
      'quests': quests.map((q) => q.toJson()).toList(),
      'deck_key': deck_key,
    };
  }

  //------------------------------------------------------------------------------

  // FROM JSON TO OBJECT CONVERSION
  factory DeckReader.fromJson(Map<String, dynamic> json) {

    DeckReader deck = DeckReader(json['deck_key'] ?? 'unknown_path');
    deck.summary = DeckSummary.fromJson(json['summary']);
    deck.quests = (json['quests'] as List).map((q) => Quest.fromJson(q)).toList();

    return deck;
  }

  //------------------------------------------------------------------------------


}

//------------------------------------------------------------------------------
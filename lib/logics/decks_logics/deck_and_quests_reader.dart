//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';

//------------------------------------------------------------------------------



// QUEST CLASS
class Quest {

  //------------------------------------------------------------------------------

  // QUEST ATTRIBUTES
  final String moment;
  final List<String> required_tools;
  final String player_type;
  final int timer;
  final String content;

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  Quest({

    required this.moment,
    required this.required_tools,
    required this.player_type,
    required this.timer,
    required this.content

  });

  //------------------------------------------------------------------------------

  // FACTORY METHOD FOR EMPTY QUEST OBJECT
  factory Quest.empty() {
    return Quest(
      moment: "none",
      required_tools: [],
      player_type: "both",
      timer: 0,
      content: "No content available",
    );
  }

  //------------------------------------------------------------------------------

  // CONVERSION FROM JSON TO OBJECT METHOD
  factory Quest.fromJson(Map<String, dynamic> json) {

    return Quest(

      moment: json['moment'] ?? "unknown",
      required_tools: json['required_tools'] != null ? List<String>.from(json['required_tools']) : [],
      player_type: json['player_type'] ?? "both",
      timer: json['timer'] ?? 0,
      content: json['content'] ?? "No content available",

    );

  }

  //------------------------------------------------------------------------------

  // CONVERSION FROM OBJECT TO JSON METHOD
  Map<String, dynamic> toJson() => {
    'moment': moment,
    'required_tools': required_tools,
    'player_type': player_type,
    'timer': timer,
    'content': content,
  };


//------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------



// QUEST SUMMARY CLASS
class QuestSummary {

  //------------------------------------------------------------------------------

  // QUEST ATTRIBUTES
  final String name;
  final String description;
  final String couple_type;
  final bool play_presence;
  final String language;
  final int total_quests;
  final List<String> required_tools;
  final List<String> tags;

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  QuestSummary({

    required this.name,
    required this.description,
    required this.couple_type,
    required this.play_presence,
    required this.language,
    required this.total_quests,
    required this.required_tools,
    required this.tags,

  });

  //------------------------------------------------------------------------------

  // CONVERSION FROM JSON TO OBJECT METHOD
  factory QuestSummary.fromJson(Map<String, dynamic> json) {

    return QuestSummary(

      name: json['name'] ?? "No data here",
      description: json['description'] ?? "No data here",
      couple_type: json['couple_type'] ?? "No data here",
      play_presence: json['play_presence'] ?? true,
      language: json['language'] ?? "No data here",
      total_quests: json['total_quests'] ?? 0,
      required_tools: json['required_tools'] != null ? List<String>.from(json['required_tools']) : [],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],

    );

  }

  //------------------------------------------------------------------------------

  // CONVERSION FROM OBJECT TO JSON METHOD
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'couple_type': couple_type,
      'play_presence': play_presence,
      'language': language,
      'total_quests': total_quests,
      'required_tools': required_tools,
      'tags': tags,
    };
  }

}



//------------------------------------------------------------------------------



// DEFAULT DECK MANAGER CLASS
class DeckReader {

  //------------------------------------------------------------------------------

  // QUEST MANAGER ATTRIBUTES
  QuestSummary summary = QuestSummary(
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
  DeckReader (this.deck_file_path);

  //------------------------------------------------------------------------------

  // LOADING JSON FROM ASSETS AND CONVERTING IT IN OBJECTS METHOD
  Future<void> load_deck() async {

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
      summary = QuestSummary.fromJson(jsonData['summary']);

      // ACQUIRING DECKS QUESTS
      quests =
          (jsonData['quests'] as List).map((q) => Quest.fromJson(q)).toList();

    } catch (e) {
      quests = [];
    }

  }

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------
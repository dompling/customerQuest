//------------------------------------------------------------------------------

// STANDARD LIBRARIES
import 'dart:convert';
import 'package:flutter/services.dart';

//------------------------------------------------------------------------------



// QUEST CLASS
class Quest {

  //------------------------------------------------------------------------------

  // QUEST ATTRIBUTES
  final int id;
  final String moment;
  final String difficulty;
  final List<String> required_tools;
  final int timer;
  final String content;

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  Quest({

    required this.id,
    required this.moment,
    required this.difficulty,
    required this.required_tools,
    required this.timer,
    required this.content

  });

  //------------------------------------------------------------------------------

  // CONVERSION FROM JSON TO OBJECT METHOD
  factory Quest.fromJson(Map<String, dynamic> json) {

    return Quest(

      id: json['id'] ?? 0,
      moment: json['moment'] ?? "unknown",
      difficulty: json['difficulty'] ?? "unknown",
      required_tools: json['required_tools'] != null ? List<String>.from(json['required_tools']) : [],
      timer: json['timer'] ?? 0,
      content: json['content'] ?? "No content available",

    );

  }

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
  final bool play_distance;
  final int total_quests;
  final int average_difficulty;
  final int average_duration;
  final List<String> required_tools;
  final bool protected;

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  QuestSummary({

    required this.name,
    required this.description,
    required this.couple_type,
    required this.play_distance,
    required this.total_quests,
    required this.average_difficulty,
    required this.average_duration,
    required this.required_tools,
    required this.protected,

  });

  //------------------------------------------------------------------------------

  // CONVERSION FROM JSON TO OBJECT METHOD
  factory QuestSummary.fromJson(Map<String, dynamic> json) {

    return QuestSummary(

      name: json['name'] ?? "No data here",
      description: json['description'] ?? "No data here",
      couple_type: json['couple_type'] ?? "No data here",
      play_distance: json['play_distance'] ?? false,
      total_quests: json['total_quests'] ?? 0,
      average_difficulty: json['average_difficulty'] ?? 0,
      average_duration: json['average_duration'] ?? 0,
      required_tools: json['required_tools'] != null ? List<String>.from(json['required_tools']) : [],
      protected: json['protected'] ?? true,

    );

  }

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------



// DEFAULT DECK MANAGER CLASS
class DeckReader {

  //------------------------------------------------------------------------------

  // QUEST MANAGER ATTRIBUTES
  late QuestSummary summary;
  late List<Quest> quests;
  final String deck_file_path;

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  DeckReader (this.deck_file_path);

  //------------------------------------------------------------------------------

  // LOADING JSON FROM ASSETS AND CONVERTING IT IN OBJECTS METHOD
  Future<void> load_deck() async {

    try {
      // LOADING JSON AS STRING
      String jsonString = await rootBundle.loadString(deck_file_path);

      // DECODING JSON FILE
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // ACQUIRING DECKS SUMMARY
      summary = QuestSummary.fromJson(jsonData['summary']);

      // ACQUIRING DECKS QUESTS
      quests =
          (jsonData['quests'] as List).map((q) => Quest.fromJson(q)).toList();

    } catch (e) {
      //print("THERE IS AN ERROR LOADING THE JSON FILE: $e");
      quests = [];
    }

  }

  //------------------------------------------------------------------------------

}



//------------------------------------------------------------------------------
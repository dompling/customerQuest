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
import 'package:hive/hive.dart';


// SETTING THE GENERATION OF G.DART FILE
part '02_deck_summary_class.g.dart';

// SETTING THE HIVE STORAGE ID
@HiveType(typeId: 1)

//------------------------------------------------------------------------------

// QUEST SUMMARY CLASS
class DeckSummary {

  //------------------------------------------------------------------------------

  // DECK SUMMARY ATTRIBUTES WITH THE CORRESPONDING FIELD ID
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  String couple_type;

  @HiveField(3)
  bool play_presence;

  @HiveField(4)
  String language;

  @HiveField(5)
  int total_quests;

  @HiveField(6)
  List<String> required_tools;

  @HiveField(7)
  List<String> tags;

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  DeckSummary({

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
  factory DeckSummary.fromJson(Map<String, dynamic> json) {

    return DeckSummary(

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








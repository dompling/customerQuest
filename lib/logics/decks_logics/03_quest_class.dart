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
part '03_quest_class.g.dart';

// SETTING THE STORAGE ID
@HiveType(typeId: 2)

//------------------------------------------------------------------------------

// QUEST CLASS
class Quest {

  //------------------------------------------------------------------------------

  // QUEST ATTRIBUTES WITH THE CORRESPONDING FIELD ID
  @HiveField(0)
  final String moment;

  @HiveField(1)
  final List<String> required_tools;

  @HiveField(2)
  final String player_type;

  @HiveField(3)
  final int timer;

  @HiveField(4)
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
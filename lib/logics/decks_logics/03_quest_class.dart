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
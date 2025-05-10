//------------------------------------------------------------------------------

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';

// HIVE
import 'package:hive/hive.dart';

// SETTING THE GENERATION OF G.DART FILE
part '02_players_class.g.dart';

// SETTING THE HIVE STORAGE ID
@HiveType(typeId: 3)

//------------------------------------------------------------------------------

// PLAYER CLASS
class Players {

  //------------------------------------------------------------------------------

  // CLASS ATTRIBUTES
  @HiveField(0)
  final String player_icon_path;                  // STOCK ASSET PATH
  @HiveField(1)
  final String player_alias;                      // CAN BE ANY STRING
  @HiveField(2)
  final bool player_sex;                          // TRUE IS FEMALE AND FALSE IS MALE

  @HiveField(3)
  List<Quest> player_early_quest_list;            // EARLY QUEST LIST BASED FILTERED ON PLAYER'S SEX
  @HiveField(4)
  List<Quest> player_mid_quest_list;              // MID QUEST LIST BASED FILTERED ON PLAYER'S SEX
  @HiveField(5)
  List<Quest> player_late_quest_list;             // LATE QUEST LIST BASED FILTERED ON PLAYER'S SEX
  @HiveField(6)
  List<Quest> player_end_quest_list;              // END QUEST LIST BASED FILTERED ON PLAYER'S SEX

  @HiveField(7)
  int player_early_quest_list_counter;            // TOTAL NUMBER OF QUESTS IN THE PLAYER'S EARLY QUESTS LIST
  @HiveField(8)
  int player_mid_quest_list_counter;              // TOTAL NUMBER OF QUESTS IN THE PLAYER'S MID QUESTS LIST
  @HiveField(9)
  int player_late_quest_list_counter;             // TOTAL NUMBER OF QUESTS IN THE PLAYER'S LATE QUESTS LIST
  @HiveField(10)
  int player_end_quest_list_counter;              // TOTAL NUMBER OF QUESTS IN THE PLAYER'S END QUESTS LIST

  @HiveField(11)
  List<Quest> player_current_quest_list;          // QUEST LIST ACTUALLY IN USE BY THE PLAYER
  @HiveField(12)
  int player_current_quest_list_counter;          // TOTAL NUMBER OF QUESTS IN THE PLAYER'S QUEST LIST ACTUALLY IN USE

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  Players({

    required this.player_icon_path,
    required this.player_alias,
    required this.player_sex,

    this.player_early_quest_list = const [],
    this.player_mid_quest_list = const [],
    this.player_late_quest_list = const [],
    this.player_end_quest_list = const [],

    this.player_early_quest_list_counter = 0,
    this.player_mid_quest_list_counter = 0,
    this.player_late_quest_list_counter = 0,
    this.player_end_quest_list_counter = 0,

    this.player_current_quest_list = const [],
    this.player_current_quest_list_counter = 0,

  });

  //------------------------------------------------------------------------------

  // FACTORY METHOD FOR EMPTY PLAYERS OBJECT
  factory Players.empty() {
    return Players(

        player_icon_path: "player_icon_path",
        player_alias: "player_alias",
        player_sex: true,

    );

  }

  //------------------------------------------------------------------------------

  // CONVERSION FROM JSON TO OBJECT METHOD
  factory Players.fromJson(Map<String, dynamic> json) {
    return Players(

      // PLAYER ICON PATH
      player_icon_path: json['player_icon_path'] ?? "",

      // PLAYER NAME
      player_alias: json['player_alias'] ?? "Unknown",

      // PLAYER SEX
      player_sex: json['player_sex'] ?? false,

      // PLAYER EARLY QUEST LIST
      player_early_quest_list: (json['player_early_quest_list'] as List<dynamic>?)
          ?.map((q) => Quest.fromJson(q))
          .toList() ?? [],

      // PLAYER MID QUEST LIST
      player_mid_quest_list: (json['player_mid_quest_list'] as List<dynamic>?)
          ?.map((q) => Quest.fromJson(q))
          .toList() ?? [],

      // PLAYER LATE QUEST LIST
      player_late_quest_list: (json['player_late_quest_list'] as List<dynamic>?)
          ?.map((q) => Quest.fromJson(q))
          .toList() ?? [],

      // PLAYER END QUEST LIST
      player_end_quest_list: (json['player_end_quest_list'] as List<dynamic>?)
          ?.map((q) => Quest.fromJson(q))
          .toList() ?? [],

      // PLAYER EARLY QUEST LIST COUNTER
      player_early_quest_list_counter: json['player_early_quest_list_counter'] ?? 0,

      // PLAYER MID QUEST LIST COUNTER
      player_mid_quest_list_counter: json['player_mid_quest_list_counter'] ?? 0,

      // PLAYER LATE QUEST LIST COUNTER
      player_late_quest_list_counter: json['player_late_quest_list_counter'] ?? 0,

      // PLAYER END QUEST LIST COUNTER
      player_end_quest_list_counter: json['player_end_quest_list_counter'] ?? 0,

      // PLAYER CURRENT QUEST LIST
      player_current_quest_list: (json['player_current_quest_list'] as List<dynamic>?)
          ?.map((q) => Quest.fromJson(q))
          .toList() ?? [],

      // PLAYER CURRENT QUEST LIST COUNTER
      player_current_quest_list_counter: json['player_current_quest_list_counter'] ?? 0,

    );
  }

  //------------------------------------------------------------------------------

  // CONVERSION FROM OBJECT TO JSON METHOD
  Map<String, dynamic> toJson() => {
    'player_icon_path': player_icon_path,
    'player_alias': player_alias,
    'player_sex': player_sex,
    'player_early_quest_list': player_early_quest_list.map((q) => q.toJson()).toList(),
    'player_mid_quest_list': player_mid_quest_list.map((q) => q.toJson()).toList(),
    'player_late_quest_list': player_late_quest_list.map((q) => q.toJson()).toList(),
    'player_end_quest_list': player_end_quest_list.map((q) => q.toJson()).toList(),
    'player_early_quest_list_counter':player_early_quest_list_counter,
    'player_mid_quest_list_counter':player_mid_quest_list_counter,
    'player_late_quest_list_counter':player_late_quest_list_counter,
    'player_end_quest_list_counter':player_end_quest_list_counter,
    'player_current_quest_list': player_current_quest_list.map((q) => q.toJson()).toList(),
    'player_current_quest_list_counter':player_current_quest_list_counter,

  };

//------------------------------------------------------------------------------

}

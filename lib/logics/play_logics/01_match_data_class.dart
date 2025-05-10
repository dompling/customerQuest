//------------------------------------------------------------------------------

// CUSTOM FILES
import 'package:loverquest/logics/decks_logics/01_deck_reader_class.dart';
import 'package:loverquest/logics/decks_logics/03_quest_class.dart';

import 'package:loverquest/logics/play_logics/02_players_class.dart';

// HIVE
import 'package:hive/hive.dart';

// SETTING THE GENERATION OF G.DART FILE
part '01_match_data_class.g.dart';

// SETTING THE HIVE STORAGE ID
@HiveType(typeId: 0)

//------------------------------------------------------------------------------

// CLASS THAT WILL HANDLE ALL THE DATA OF THE CURRENT MATCH
class MatchData {

  //------------------------------------------------------------------------------

  // CLASS ATTRIBUTES
  @HiveField(0)
  bool play_local;                        // GAME TYPE - FILLED IN PLAY PAGES 01 - TRUE FOR LOCAL PLAY - FALSE FOR ONLINE PLAY
  @HiveField(1)
  String couple_type;                     // COUPLE TYPE - FILLED IN PLAY PAGES 02 - CAN BE "hetero", "lesbian" OR "gay"
  @HiveField(2)
  Players player_one;                     // PLAYER ONE OBJECT - FILLED IN PLAY PAGES 03 - FOR MORE INFO REFERS TO PLAY LOGICS 02
  @HiveField(3)
  Players player_two;                     // PLAYER ONE OBJECT - FILLED IN PLAY PAGES 03 - FOR MORE INFO REFERS TO PLAY LOGICS 02
  @HiveField(4)
  DeckReader selected_deck;               // DECK TO PLAY - FILLED IN PLAY PAGES 05 - FOR MORE INFO REFERS TO DECK LOGICS 01
  @HiveField(5)
  List<Quest> deck_early_quest_list;      // DECK EARLY QUEST LIST - FILLED IN PLAY PAGES 06 - FOR MORE INFO REFERS TO DECK LOGICS 01-03
  @HiveField(6)
  List<Quest> deck_mid_quest_list;        // DECK MID QUEST LIST - FILLED IN PLAY PAGES 06 - FOR MORE INFO REFERS TO DECK LOGICS 01-03
  @HiveField(7)
  List<Quest> deck_late_quest_list;       // DECK LATE QUEST LIST - FILLED IN PLAY PAGES 06 - FOR MORE INFO REFERS TO DECK LOGICS 01-03
  @HiveField(8)
  List<Quest> deck_end_quest_list;        // DECK END QUEST LIST - FILLED IN PLAY PAGES 06 - FOR MORE INFO REFERS TO DECK LOGICS 01-03
  @HiveField(9)
  int game_pace_multiplier;               // NUMBER THAT REPRESENT THE QUEST SWITCH MULTIPLIER - FILLED IN PLAY PAGES 07 - CAN BE 1-2-3-4
  @HiveField(10)
  String current_player_alias;            // CURRENT PLAYER NAME - FILLED IN PLAY PAGES 08 - CAN BE ANY STRING THAT MATCHES PLAYER ONE OR PLAYER TWO ALIAS
  @HiveField(11)
  Quest current_quest;                    // CURRENT QUEST - FILLED IN PLAY PAGES 08 - CAN BE ANY QUEST FROM PLAYER ONE OR TWO




  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  MatchData({

    this.play_local = true,
    this.couple_type = "hetero",
    Players? player_one,
    Players? player_two,
    DeckReader? selected_deck,
    List<Quest>? deck_early_quest_list,
    List<Quest>? deck_mid_quest_list,
    List<Quest>? deck_late_quest_list,
    List<Quest>? deck_end_quest_list,
    this.game_pace_multiplier = 1,
    this.current_player_alias = "",
    Quest? current_quest,


  }) :
        player_one = player_one ?? Players.empty(),
        player_two = player_two ?? Players.empty(),
        selected_deck = selected_deck ?? DeckReader("placeholder"),
        deck_early_quest_list = deck_early_quest_list ?? [],
        deck_mid_quest_list = deck_mid_quest_list ?? [],
        deck_late_quest_list = deck_late_quest_list ?? [],
        deck_end_quest_list = deck_end_quest_list ?? [],
        current_quest = current_quest ?? Quest.empty()
  ;


  //------------------------------------------------------------------------------

  // FROM OBJECT TO JSON CONVERSION METHOD
  Map<String, dynamic> toJson() {
    return {
      'play_local': play_local,
      'couple_type': couple_type,
      'player_one': player_one.toJson(),
      'player_two': player_two.toJson(),
      'selected_deck': selected_deck.toJson(),
      'deck_early_quest_list': deck_early_quest_list.map((q) => q.toJson()).toList(),
      'deck_mid_quest_list': deck_mid_quest_list.map((q) => q.toJson()).toList(),
      'deck_late_quest_list': deck_late_quest_list.map((q) => q.toJson()).toList(),
      'deck_end_quest_list': deck_end_quest_list.map((q) => q.toJson()).toList(),
      'game_pace_multiplier': game_pace_multiplier,
      'current_player_alias': current_player_alias,
      'current_quest': current_quest.toJson(),
    };
  }

  //------------------------------------------------------------------------------

  // FROM JSON TO OBJECT CONVERSION
  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      play_local: json['play_local'] ?? true,
      couple_type: json['couple_type'] ?? "hetero",
      player_one: Players.fromJson(json['player_one']),
      player_two: Players.fromJson(json['player_two']),
      selected_deck: DeckReader.fromJson(json['selected_deck']),
      deck_early_quest_list: (json['deck_early_quest_list'] as List).map((q) => Quest.fromJson(q)).toList(),
      deck_mid_quest_list: (json['deck_mid_quest_list'] as List).map((q) => Quest.fromJson(q)).toList(),
      deck_late_quest_list: (json['deck_late_quest_list'] as List).map((q) => Quest.fromJson(q)).toList(),
      deck_end_quest_list: (json['deck_end_quest_list'] as List).map((q) => Quest.fromJson(q)).toList(),
      game_pace_multiplier: json['game_pace_multiplier'] ?? 1,
      current_player_alias: json['current_player_alias'] ?? "",
      current_quest: Quest.fromJson(json['current_quest']),
    );
  }

//------------------------------------------------------------------------------



}

//------------------------------------------------------------------------------
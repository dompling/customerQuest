//------------------------------------------------------------------------------

// PLAYER CLASS
class Players {

  //------------------------------------------------------------------------------

  // CLASS ATTRIBUTES
  final String player_icon_path;
  final String player_alias;
  final bool player_sex;

  //------------------------------------------------------------------------------

  // CLASS CONSTRUCTOR
  Players({
    required this.player_icon_path,
    required this.player_alias,
    required this.player_sex,
  });

  //------------------------------------------------------------------------------

  // CONVERSION FROM JSON TO OBJECT METHOD
  factory Players.fromJson(Map<String, dynamic> json) {
    return Players(
      player_icon_path: json['player_icon_path'] ?? "",
      player_alias: json['player_alias'] ?? "Unknown",
      player_sex: json['player_sex'] ?? false,
    );
  }

  //------------------------------------------------------------------------------

  // CONVERSION FROM OBJECT TO JSON METHOD
  Map<String, dynamic> toJson() => {
    'player_icon_path': player_icon_path,
    'player_alias': player_alias,
    'player_sex': player_sex,
  };

  //------------------------------------------------------------------------------

}

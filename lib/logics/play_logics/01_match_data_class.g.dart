// GENERATED CODE - DO NOT MODIFY BY HAND

part of '01_match_data_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchDataAdapter extends TypeAdapter<MatchData> {
  @override
  final int typeId = 0;

  @override
  MatchData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatchData(
      play_local: fields[0] as bool,
      couple_type: fields[1] as String,
      player_one: fields[2] as Players?,
      player_two: fields[3] as Players?,
      selected_deck: fields[4] as DeckReader?,
      deck_early_quest_list: (fields[5] as List?)?.cast<Quest>(),
      deck_mid_quest_list: (fields[6] as List?)?.cast<Quest>(),
      deck_late_quest_list: (fields[7] as List?)?.cast<Quest>(),
      deck_end_quest_list: (fields[8] as List?)?.cast<Quest>(),
      game_pace_multiplier: fields[9] as int,
      current_player_alias: fields[10] as String,
      current_quest: fields[11] as Quest?,
    );
  }

  @override
  void write(BinaryWriter writer, MatchData obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.play_local)
      ..writeByte(1)
      ..write(obj.couple_type)
      ..writeByte(2)
      ..write(obj.player_one)
      ..writeByte(3)
      ..write(obj.player_two)
      ..writeByte(4)
      ..write(obj.selected_deck)
      ..writeByte(5)
      ..write(obj.deck_early_quest_list)
      ..writeByte(6)
      ..write(obj.deck_mid_quest_list)
      ..writeByte(7)
      ..write(obj.deck_late_quest_list)
      ..writeByte(8)
      ..write(obj.deck_end_quest_list)
      ..writeByte(9)
      ..write(obj.game_pace_multiplier)
      ..writeByte(10)
      ..write(obj.current_player_alias)
      ..writeByte(11)
      ..write(obj.current_quest);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

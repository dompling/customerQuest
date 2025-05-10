// GENERATED CODE - DO NOT MODIFY BY HAND

part of '02_players_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayersAdapter extends TypeAdapter<Players> {
  @override
  final int typeId = 3;

  @override
  Players read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Players(
      player_icon_path: fields[0] as String,
      player_alias: fields[1] as String,
      player_sex: fields[2] as bool,
      player_early_quest_list: (fields[3] as List).cast<Quest>(),
      player_mid_quest_list: (fields[4] as List).cast<Quest>(),
      player_late_quest_list: (fields[5] as List).cast<Quest>(),
      player_end_quest_list: (fields[6] as List).cast<Quest>(),
      player_early_quest_list_counter: fields[7] as int,
      player_mid_quest_list_counter: fields[8] as int,
      player_late_quest_list_counter: fields[9] as int,
      player_end_quest_list_counter: fields[10] as int,
      player_current_quest_list: (fields[11] as List).cast<Quest>(),
      player_current_quest_list_counter: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Players obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.player_icon_path)
      ..writeByte(1)
      ..write(obj.player_alias)
      ..writeByte(2)
      ..write(obj.player_sex)
      ..writeByte(3)
      ..write(obj.player_early_quest_list)
      ..writeByte(4)
      ..write(obj.player_mid_quest_list)
      ..writeByte(5)
      ..write(obj.player_late_quest_list)
      ..writeByte(6)
      ..write(obj.player_end_quest_list)
      ..writeByte(7)
      ..write(obj.player_early_quest_list_counter)
      ..writeByte(8)
      ..write(obj.player_mid_quest_list_counter)
      ..writeByte(9)
      ..write(obj.player_late_quest_list_counter)
      ..writeByte(10)
      ..write(obj.player_end_quest_list_counter)
      ..writeByte(11)
      ..write(obj.player_current_quest_list)
      ..writeByte(12)
      ..write(obj.player_current_quest_list_counter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

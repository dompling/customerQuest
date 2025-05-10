// GENERATED CODE - DO NOT MODIFY BY HAND

part of '03_quest_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestAdapter extends TypeAdapter<Quest> {
  @override
  final int typeId = 2;

  @override
  Quest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quest(
      moment: fields[0] as String,
      required_tools: (fields[1] as List).cast<String>(),
      player_type: fields[2] as String,
      timer: fields[3] as int,
      content: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Quest obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.moment)
      ..writeByte(1)
      ..write(obj.required_tools)
      ..writeByte(2)
      ..write(obj.player_type)
      ..writeByte(3)
      ..write(obj.timer)
      ..writeByte(4)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

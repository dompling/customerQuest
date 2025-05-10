// GENERATED CODE - DO NOT MODIFY BY HAND

part of '02_deck_summary_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeckSummaryAdapter extends TypeAdapter<DeckSummary> {
  @override
  final int typeId = 1;

  @override
  DeckSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeckSummary(
      name: fields[0] as String,
      description: fields[1] as String,
      couple_type: fields[2] as String,
      play_presence: fields[3] as bool,
      language: fields[4] as String,
      total_quests: fields[5] as int,
      required_tools: (fields[6] as List).cast<String>(),
      tags: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DeckSummary obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.couple_type)
      ..writeByte(3)
      ..write(obj.play_presence)
      ..writeByte(4)
      ..write(obj.language)
      ..writeByte(5)
      ..write(obj.total_quests)
      ..writeByte(6)
      ..write(obj.required_tools)
      ..writeByte(7)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeckSummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

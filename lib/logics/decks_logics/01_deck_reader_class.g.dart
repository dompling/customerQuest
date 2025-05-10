// GENERATED CODE - DO NOT MODIFY BY HAND

part of '01_deck_reader_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeckReaderAdapter extends TypeAdapter<DeckReader> {
  @override
  final int typeId = 4;

  @override
  DeckReader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeckReader(
      fields[2] as String,
    )
      ..summary = fields[0] as DeckSummary
      ..quests = (fields[1] as List).cast<Quest>();
  }

  @override
  void write(BinaryWriter writer, DeckReader obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.summary)
      ..writeByte(1)
      ..write(obj.quests)
      ..writeByte(2)
      ..write(obj.deck_file_path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeckReaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

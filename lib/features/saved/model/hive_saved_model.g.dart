// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_saved_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveSavedModelAdapter extends TypeAdapter<HiveSavedModel> {
  @override
  final int typeId = 0;

  @override
  HiveSavedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveSavedModel(
      userId: fields[0] as int,
      trainingId: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveSavedModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.trainingId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveSavedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

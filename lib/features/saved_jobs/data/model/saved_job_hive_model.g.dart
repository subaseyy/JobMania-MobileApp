// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_job_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedJobHiveModelAdapter extends TypeAdapter<SavedJobHiveModel> {
  @override
  final int typeId = 6;

  @override
  SavedJobHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedJobHiveModel(
      savedId: fields[0] as String?,
      userId: fields[1] as String,
      jobId: fields[2] as String,
      savedAt: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedJobHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.savedId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.jobId)
      ..writeByte(3)
      ..write(obj.savedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedJobHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

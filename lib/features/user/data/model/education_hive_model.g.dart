// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EducationHiveModelAdapter extends TypeAdapter<EducationHiveModel> {
  @override
  final int typeId = 3;

  @override
  EducationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EducationHiveModel(
      id: fields[0] as String?,
      university: fields[1] as String,
      degree: fields[2] as String,
      duration: fields[3] as String,
      description: fields[4] as String,
      logo: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EducationHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.university)
      ..writeByte(2)
      ..write(obj.degree)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.logo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

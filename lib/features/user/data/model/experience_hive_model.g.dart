// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExperienceHiveModelAdapter extends TypeAdapter<ExperienceHiveModel> {
  @override
  final int typeId = 2;

  @override
  ExperienceHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExperienceHiveModel(
      id: fields[0] as String?,
      company: fields[1] as String,
      role: fields[2] as String,
      type: fields[3] as String,
      location: fields[4] as String,
      duration: fields[5] as String,
      period: fields[6] as String,
      description: fields[7] as String,
      logo: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExperienceHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.company)
      ..writeByte(2)
      ..write(obj.role)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.period)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.logo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperienceHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_post_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobPostHiveModelAdapter extends TypeAdapter<JobPostHiveModel> {
  @override
  final int typeId = 5;

  @override
  JobPostHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobPostHiveModel(
      jobId: fields[0] as String?,
      employerId: fields[1] as String,
      title: fields[2] as String,
      company: fields[3] as String,
      description: fields[4] as String,
      location: fields[5] as String,
      type: fields[6] as String,
      salaryMin: fields[7] as double?,
      salaryMax: fields[8] as double?,
      currency: fields[9] as String,
      requirements: (fields[10] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, JobPostHiveModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.jobId)
      ..writeByte(1)
      ..write(obj.employerId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.company)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.location)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.salaryMin)
      ..writeByte(8)
      ..write(obj.salaryMax)
      ..writeByte(9)
      ..write(obj.currency)
      ..writeByte(10)
      ..write(obj.requirements);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobPostHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_application_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobApplicationHiveModelAdapter
    extends TypeAdapter<JobApplicationHiveModel> {
  @override
  final int typeId = 7;

  @override
  JobApplicationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobApplicationHiveModel(
      applicationId: fields[0] as String?,
      jobId: fields[1] as String,
      applicantId: fields[2] as String,
      resume: fields[3] as String,
      coverLetter: fields[4] as String,
      status: fields[5] as String,
      appliedAt: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JobApplicationHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.applicationId)
      ..writeByte(1)
      ..write(obj.jobId)
      ..writeByte(2)
      ..write(obj.applicantId)
      ..writeByte(3)
      ..write(obj.resume)
      ..writeByte(4)
      ..write(obj.coverLetter)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.appliedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobApplicationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

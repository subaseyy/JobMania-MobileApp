// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileHiveModelAdapter extends TypeAdapter<ProfileHiveModel> {
  @override
  final int typeId = 1;

  @override
  ProfileHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileHiveModel(
      userId: fields[0] as String?,
      fullName: fields[1] as String,
      title: fields[2] as String,
      company: fields[3] as String,
      location: fields[4] as String,
      phone: fields[5] as String,
      dob: fields[6] as String,
      gender: fields[7] as String,
      accountType: fields[8] as String,
      profilePicture: fields[9] as String,
      bgImage: fields[10] as String,
      skills: (fields[11] as List).cast<String>(),
      experience: (fields[12] as List).cast<ExperienceHiveModel>(),
      education: (fields[13] as List).cast<EducationHiveModel>(),
      portfolio: (fields[14] as List).cast<PortfolioHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProfileHiveModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.company)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.dob)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.accountType)
      ..writeByte(9)
      ..write(obj.profilePicture)
      ..writeByte(10)
      ..write(obj.bgImage)
      ..writeByte(11)
      ..write(obj.skills)
      ..writeByte(12)
      ..write(obj.experience)
      ..writeByte(13)
      ..write(obj.education)
      ..writeByte(14)
      ..write(obj.portfolio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

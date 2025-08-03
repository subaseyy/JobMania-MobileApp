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
      profilePicture: fields[9] as String,
      bgImage: fields[10] as String,
      skills: (fields[11] as List).cast<String>(),
      experience: (fields[12] as List).cast<ExperienceHiveModel>(),
      education: (fields[13] as List).cast<EducationHiveModel>(),
      portfolio: (fields[14] as List).cast<PortfolioHiveModel>(),
      about: fields[15] as String,
      email: fields[16] as String,
      languages: fields[17] as String,
      instagram: fields[18] as String,
      twitter: fields[19] as String,
      website: fields[20] as String,
      createdAt: fields[21] as String,
      updatedAt: fields[22] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileHiveModel obj) {
    writer
      ..writeByte(20)
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
      ..write(obj.portfolio)
      ..writeByte(15)
      ..write(obj.about)
      ..writeByte(16)
      ..write(obj.email)
      ..writeByte(17)
      ..write(obj.languages)
      ..writeByte(18)
      ..write(obj.instagram)
      ..writeByte(19)
      ..write(obj.twitter)
      ..writeByte(20)
      ..write(obj.website)
      ..writeByte(21)
      ..write(obj.createdAt)
      ..writeByte(22)
      ..write(obj.updatedAt);
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

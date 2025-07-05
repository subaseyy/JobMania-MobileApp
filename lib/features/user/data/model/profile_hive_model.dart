import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/features/user/data/model/experience_hive_model.dart';
import 'package:jobmaniaapp/features/user/data/model/education_hive_model.dart';
import 'package:jobmaniaapp/features/user/data/model/portfolio_hive_model.dart';
import 'package:jobmaniaapp/features/user/domain/entity/profile_entity.dart';

part 'profile_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.profileTableId)
class ProfileHiveModel extends Equatable {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String company;

  @HiveField(4)
  final String location;

  @HiveField(5)
  final String phone;

  @HiveField(6)
  final String dob;

  @HiveField(7)
  final String gender;

  @HiveField(8)
  final String accountType;

  @HiveField(9)
  final String profilePicture;

  @HiveField(10)
  final String bgImage;

  @HiveField(11)
  final List<String> skills;

  @HiveField(12)
  final List<ExperienceHiveModel> experience;

  @HiveField(13)
  final List<EducationHiveModel> education;

  @HiveField(14)
  final List<PortfolioHiveModel> portfolio;

  ProfileHiveModel({
    String? userId,
    required this.fullName,
    required this.title,
    required this.company,
    required this.location,
    required this.phone,
    required this.dob,
    required this.gender,
    required this.accountType,
    required this.profilePicture,
    required this.bgImage,
    required this.skills,
    required this.experience,
    required this.education,
    required this.portfolio,
  }) : userId = userId ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "title": title,
      "company": company,
      "location": location,
      "phone": phone,
      "dob": dob,
      "gender": gender,
      "account_type": accountType,
      "profile_picture": profilePicture,
      "bg_image": bgImage,
      "skills": skills,
      "experience": experience.map((e) => e.toJson()).toList(),
      "education": education.map((e) => e.toJson()).toList(),
      "portfolio": portfolio.map((p) => p.toJson()).toList(),
    };
  }

  const ProfileHiveModel.initial()
    : userId = '',
      fullName = '',
      title = '',
      company = '',
      location = '',
      phone = '',
      dob = '',
      gender = '',
      accountType = '',
      profilePicture = '',
      bgImage = '',
      skills = const [],
      experience = const [],
      education = const [],
      portfolio = const [];

  factory ProfileHiveModel.fromEntity(ProfileEntity entity) {
    return ProfileHiveModel(
      userId: entity.userId,
      fullName: entity.fullName,
      title: entity.title,
      company: entity.company,
      location: entity.location,
      phone: entity.phone,
      dob: entity.dob,
      gender: entity.gender,
      accountType: entity.accountType,
      profilePicture: entity.profilePicture,
      bgImage: entity.bgImage,
      skills: entity.skills,
      experience:
          entity.experience
              .map((e) => ExperienceHiveModel.fromEntity(e))
              .toList(),
      education:
          entity.education
              .map((e) => EducationHiveModel.fromEntity(e))
              .toList(),
      portfolio:
          entity.portfolio
              .map((e) => PortfolioHiveModel.fromEntity(e))
              .toList(),
    );
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      userId: userId,
      fullName: fullName,
      title: title,
      company: company,
      location: location,
      phone: phone,
      dob: dob,
      gender: gender,
      accountType: accountType,
      profilePicture: profilePicture,
      bgImage: bgImage,
      skills: skills,
      experience: experience.map((e) => e.toEntity()).toList(),
      education: education.map((e) => e.toEntity()).toList(),
      portfolio: portfolio.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
    userId,
    fullName,
    title,
    company,
    location,
    phone,
    dob,
    gender,
    accountType,
    profilePicture,
    bgImage,
    skills,
    experience,
    education,
    portfolio,
  ];
}

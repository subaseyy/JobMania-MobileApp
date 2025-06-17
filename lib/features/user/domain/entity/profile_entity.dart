import 'package:equatable/equatable.dart';
import 'experience_entity.dart';
import 'education_entity.dart';
import 'portfolio_entity.dart';

class ProfileEntity extends Equatable {
  final String userId;
  final String fullName;
  final String title;
  final String company;
  final String location;
  final String phone;
  final String dob;
  final String gender;
  final String accountType;
  final String profilePicture;
  final String bgImage;
  final List<String> skills;
  final List<ExperienceEntity> experience;
  final List<EducationEntity> education;
  final List<PortfolioEntity> portfolio;

  const ProfileEntity({
    required this.userId,
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
  });

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

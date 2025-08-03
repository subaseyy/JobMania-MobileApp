import 'package:equatable/equatable.dart';
import 'package:jobmaniaapp/features/user/domain/entity/education_entity.dart';
import 'package:jobmaniaapp/features/user/domain/entity/experience_entity.dart';
import 'package:jobmaniaapp/features/user/domain/entity/portfolio_entity.dart';

class ProfileEntity extends Equatable {
  final String userId;
  final String fullName;
  final String title;
  final String company;
  final String location;
  final String phone;

  final String profilePicture;
  final String bgImage;
  final String about;
  final String languages;
  final String email;
  final String instagram;
  final String twitter;
  final String website;
  final String createdAt;
  final String updatedAt;

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

    required this.profilePicture,
    required this.bgImage,
    required this.about,
    required this.languages,
    required this.email,
    required this.instagram,
    required this.twitter,
    required this.website,
    required this.createdAt,
    required this.updatedAt,
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

    profilePicture,
    bgImage,
    about,
    languages,
    email,
    instagram,
    twitter,
    website,
    createdAt,
    updatedAt,
    skills,
    experience,
    education,
    portfolio,
  ];
}

extension ProfileEntityCopyWith on ProfileEntity {
  ProfileEntity copyWith({
    String? fullName,
    String? title,
    String? company,
    String? location,
    String? phone,

    String? profilePicture,
    String? bgImage,
    List<String>? skills,
    List<EducationEntity>? education,
    List<ExperienceEntity>? experience,
    List<PortfolioEntity>? portfolio,
    String? email,
    String? about,
    String? languages,
    String? instagram,
    String? twitter,
    String? website,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProfileEntity(
      userId: this.userId, // Use this.userId here to keep the original value
      fullName: fullName ?? this.fullName,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      phone: phone ?? this.phone,

      profilePicture: profilePicture ?? this.profilePicture,
      bgImage: bgImage ?? this.bgImage,
      skills: skills ?? this.skills,
      education: education ?? this.education,
      experience: experience ?? this.experience,
      portfolio: portfolio ?? this.portfolio,
      email: email ?? this.email,
      about: about ?? this.about,
      languages: languages ?? this.languages,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      website: website ?? this.website,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

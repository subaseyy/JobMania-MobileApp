import 'package:equatable/equatable.dart';

class ExperienceEntity extends Equatable {
  final String id;
  final String company;
  final String role;
  final String type;
  final String location;
  final String duration;
  final String period;
  final String description;
  final String logo;

  const ExperienceEntity({
    required this.id,
    required this.company,
    required this.role,
    required this.type,
    required this.location,
    required this.duration,
    required this.period,
    required this.description,
    required this.logo,
  });

  factory ExperienceEntity.fromJson(Map<String, dynamic> json) {
    return ExperienceEntity(
      id: json['_id'] ?? '',
      company: json['company'] ?? '',
      role: json['role'] ?? '',
      type: json['type'] ?? '',
      location: json['location'] ?? '',
      duration: json['duration'] ?? '',
      period: json['period'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    id,
    company,
    role,
    type,
    location,
    duration,
    period,
    description,
    logo,
  ];
}

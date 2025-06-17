import 'package:equatable/equatable.dart';

class EducationEntity extends Equatable {
  final String id;
  final String university;
  final String degree;
  final String duration;
  final String description;
  final String logo;

  const EducationEntity({
    required this.id,
    required this.university,
    required this.degree,
    required this.duration,
    required this.description,
    required this.logo,
  });

  @override
  List<Object?> get props => [
    id,
    university,
    degree,
    duration,
    description,
    logo,
  ];
}

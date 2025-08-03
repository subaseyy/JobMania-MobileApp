import 'package:equatable/equatable.dart';

class JobPostEntity extends Equatable {
  final String jobId;
  final String employerId;
  final String title;
  final String company;
  final String description;
  final String location;
  final String type; // full-time, part-time, etc.
  final double? salaryMin;
  final double? salaryMax;
  final String currency;
  final List<String> requirements;
  

  const JobPostEntity({
    required this.jobId,
    required this.employerId,
    required this.title,
    required this.company,
    required this.description,
    required this.location,
    required this.type,
    this.salaryMin,
    this.salaryMax,
    required this.currency,
    required this.requirements,
  });

  @override
  List<Object?> get props => [
    jobId,
    employerId,
    title,
    company,
    description,
    location,
    type,
    salaryMin,
    salaryMax,
    currency,
    requirements,
  ];

  get id => null;
}

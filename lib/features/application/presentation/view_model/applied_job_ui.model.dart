import 'package:jobmaniaapp/features/application/domain/entity/job_application_entity.dart';
import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';

class AppliedJobUIModel {
  final JobApplicationEntity application;
  final JobPostEntity job;

  AppliedJobUIModel({required this.application, required this.job});
}

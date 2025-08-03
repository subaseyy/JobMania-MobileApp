import '../entity/job_application_entity.dart';

abstract class JobApplicationRepository {
  Future<List<JobApplicationEntity>> getMyJobApplications();
}

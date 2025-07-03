import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';

abstract class JobRepository {
  Future<List<JobPostEntity>> getAllJobs();
}

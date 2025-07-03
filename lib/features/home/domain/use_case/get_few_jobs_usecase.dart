import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';
import 'package:jobmaniaapp/features/job/domain/repository/job_repository.dart';

class GetFewJobsUseCase {
  final JobRepository repository;

  GetFewJobsUseCase(this.repository);

  Future<List<JobPostEntity>> call() async {
    final allJobs = await repository.getAllJobs();
    return allJobs.take(4).toList(); // just fetch a few (e.g., 4)
  }
}

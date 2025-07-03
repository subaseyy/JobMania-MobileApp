import 'package:dio/dio.dart';
import 'package:jobmaniaapp/app/constants/api_endpoint.dart';
import 'package:jobmaniaapp/features/job/domain/entity/job_entity.dart';
import 'package:jobmaniaapp/features/job/domain/repository/job_repository.dart';

class JobRepositoryImpl implements JobRepository {
  final Dio dio;

  JobRepositoryImpl({required this.dio});

  @override
  @override
  @override
  Future<List<JobPostEntity>> getAllJobs() async {
    final res = await dio.get('${ApiEndpoints.baseUrl}${ApiEndpoints.allJobs}');

    final data = res.data['data'] as List;

    return data.map((e) {
      final rawRequirements = e['requirements'];
      final requirements =
          (rawRequirements is List)
              ? rawRequirements.map((item) => item.toString()).toList()
              : <String>[];

      return JobPostEntity(
        jobId: e['_id'] ?? '',
        employerId: e['employer'] ?? '',
        title: e['title'] ?? '',
        company: e['company'] ?? '',
        description: e['description'] ?? '',
        location: e['location'] ?? '',
        type: e['type'] ?? '',
        salaryMin: (e['salaryMin'] as num?)?.toDouble(),
        salaryMax: (e['salaryMax'] as num?)?.toDouble(),
        currency: e['currency'] ?? '',
        requirements: requirements,
      );
    }).toList();
  }
}

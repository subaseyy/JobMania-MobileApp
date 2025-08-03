import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:jobmaniaapp/features/application/data/model/job_application_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jobmaniaapp/app/constants/api_endpoint.dart';

import '../../domain/entity/job_application_entity.dart';
import '../../domain/repository/job_application_repository.dart';

class JobApplicationRepositoryImpl implements JobApplicationRepository {
  final Dio dio;

  JobApplicationRepositoryImpl(this.dio);

  @override
  Future<List<JobApplicationEntity>> getMyJobApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Auth token not found in SharedPreferences');
    }

    final response = await dio.get(
      '${ApiEndpoints.baseUrl}${ApiEndpoints.myjobs}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      // Dio response data is already decoded JSON
      final List data = response.data['data'];

      print('Fetched ${data.length} job applications');

      return data
          .map((json) => JobApplicationModel.fromJson(json).toEntity())
          .toList();
    } else {
      throw Exception(
        'Failed to load applied jobs: ${response.statusCode} ${response.statusMessage}',
      );
    }
  }
}

import 'package:dio/dio.dart';
import 'package:jobmaniaapp/app/constants/api_endpoint.dart';
import 'package:jobmaniaapp/features/user/data/model/profile_hive_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource({required this.dio});

  Future<ProfileHiveModel> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('Auth token not found in SharedPreferences');
    }

    final response = await dio.get(
      '${ApiEndpoints.baseUrl}${ApiEndpoints.profile}',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final data = response.data['data'];
      final user = data['user'];
      final profile = data['profile'];

      return ProfileHiveModel(
        userId: user['_id'],
        fullName: user['full_name'],
        title: '',
        company: '',
        location: '',
        phone: profile['contact_number'] ?? '',
        dob: '',
        gender: '',
        accountType: user['role'] ?? '',
        profilePicture: profile['profile_picture'] ?? '',
        bgImage: profile['bg_image'] ?? '',
        skills: List<String>.from(profile['skills'] ?? []),
        experience: const [],
        education: const [],
        portfolio: const [],
      );
    } else {
      throw Exception('Failed to fetch profile');
    }
  }

  Future<void> updateProfile(ProfileHiveModel model) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Auth token not found in SharedPreferences');
      }

      final data = model.toJson();

      await dio.put(
        ApiEndpoints.profile,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}

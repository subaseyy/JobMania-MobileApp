import 'package:dio/dio.dart';
import 'package:jobmaniaapp/app/constants/api_endpoint.dart';
import 'package:jobmaniaapp/features/user/data/model/education_hive_model.dart';
import 'package:jobmaniaapp/features/user/data/model/experience_hive_model.dart';
import 'package:jobmaniaapp/features/user/data/model/portfolio_hive_model.dart';
import 'package:jobmaniaapp/features/user/data/model/profile_hive_model.dart';
import 'package:jobmaniaapp/features/user/domain/entity/education_entity.dart';
import 'package:jobmaniaapp/features/user/domain/entity/experience_entity.dart';
import 'package:jobmaniaapp/features/user/domain/entity/portfolio_entity.dart';
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

      final rawExperiences = profile['experiences'];
      final rawEducation = profile['education'];
      final rawPortfolios = profile['portfolios'];

      return ProfileHiveModel(
        userId: profile['user'] ?? '',
        fullName: profile['full_name'] ?? '',
        title: profile['title'] ?? '',
        company: profile['company'] ?? '',
        location: profile['location'] ?? '',
        phone: profile['contact_number'] ?? '',
    
        profilePicture: profile['profile_picture'] ?? '',
        bgImage: profile['bg_image'] ?? '',
        skills: List<String>.from(profile['skills'] ?? []),

        email: profile['email'] ?? '',
        about: profile['about'] ?? '',
        languages: profile['languages'] ?? '',
        instagram: profile['instagram'] ?? '',
        twitter: profile['twitter'] ?? '',
        website: profile['website'] ?? '',
        createdAt: profile['created_at'] ?? '',
        updatedAt: profile['updated_at'] ?? '',

        experience:
            (rawExperiences is List)
                ? rawExperiences
                    .map(
                      (e) => ExperienceHiveModel.fromEntity(
                        ExperienceEntity.fromJson(e),
                      ),
                    )
                    .toList()
                : [],

        education:
            (rawEducation is List)
                ? rawEducation
                    .map(
                      (e) => EducationHiveModel.fromEntity(
                        EducationEntity.fromJson(e),
                      ),
                    )
                    .toList()
                : [],

        portfolio:
            (rawPortfolios is List)
                ? rawPortfolios
                    .map(
                      (e) => PortfolioHiveModel.fromEntity(
                        PortfolioEntity.fromJson(e),
                      ),
                    )
                    .toList()
                : [],
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

      data['experience'] = model.experience.map((e) => e.toJson()).toList();
      data['education'] = model.education.map((e) => e.toJson()).toList();
      data['portfolio'] = model.portfolio.map((e) => e.toJson()).toList();

      await dio.put(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.profile}',
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

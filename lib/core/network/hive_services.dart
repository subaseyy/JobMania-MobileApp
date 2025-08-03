import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:jobmaniaapp/core/constants/hive_table_constant.dart';
import 'package:jobmaniaapp/features/auth/data/model/auth_hive_model.dart';
import 'package:jobmaniaapp/features/user/data/model/profile_hive_model.dart';
import 'package:jobmaniaapp/features/user/data/model/experience_hive_model.dart';
import 'package:jobmaniaapp/features/user/data/model/education_hive_model.dart';
import 'package:jobmaniaapp/features/user/data/model/portfolio_hive_model.dart';
import 'package:jobmaniaapp/features/job/data/model/job_post_hive_model.dart';

import 'package:jobmaniaapp/features/application/data/model/job_application_hive_model.dart';

class HiveService {
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/jobmania_db';

    Hive.init(path);

    // Register all adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(ProfileHiveModelAdapter());
    Hive.registerAdapter(ExperienceHiveModelAdapter());
    Hive.registerAdapter(EducationHiveModelAdapter());
    Hive.registerAdapter(PortfolioHiveModelAdapter());
    Hive.registerAdapter(JobPostHiveModelAdapter());

    // Hive.registerAdapter(JobApplicationHiveModelAdapter());
  }

  // ─────────────────── AUTH ───────────────────
  Future<void> registerAuth(AuthHiveModel user) async {
    final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    await box.put(user.userId, user);
  }

  Future<void> addAuth(AuthHiveModel user) async {
    final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    await box.clear(); // Ensure only one auth entry
    await box.put(user.userId, user);
  }

  Future<void> deleteAuth(String id) async {
    final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    return box.values.toList();
  }

  Future<void> clearAuth() async {
    final box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.authBox);
    await box.clear();
  }

  // ─────────────────── PROFILE ───────────────────

  Future<ProfileHiveModel?> getProfile(String id) async {
    final box = await Hive.openBox<ProfileHiveModel>(
      HiveTableConstant.profileBox,
    );
    return box.get(id);
  }

  // ─────────────────── JOB POST ───────────────────
  Future<void> saveJobPost(JobPostHiveModel job) async {
    final box = await Hive.openBox<JobPostHiveModel>(
      HiveTableConstant.jobPostBox,
    );
    await box.put(job.jobId, job);
  }

  Future<List<JobPostHiveModel>> getAllJobs() async {
    final box = await Hive.openBox<JobPostHiveModel>(
      HiveTableConstant.jobPostBox,
    );
    return box.values.toList();
  }

  // // ─────────────────── JOB APPLICATIONS ───────────────────
  // Future<void> applyToJob(JobApplicationHiveModel app) async {
  //   final box = await Hive.openBox<JobApplicationHiveModel>(
  //     HiveTableConstant.jobApplicationBox,
  //   );
  //   await box.put(app.applicationId, app);
  // }

  // Future<List<JobApplicationHiveModel>> getAllApplications() async {
  //   final box = await Hive.openBox<JobApplicationHiveModel>(
  //     HiveTableConstant.jobApplicationBox,
  //   );
  //   return box.values.toList();
  // }

  // ─────────────────── CLEANUP ───────────────────
  Future<void> clearAll() async {
    await Hive.deleteFromDisk();
    await Hive.deleteBoxFromDisk(HiveTableConstant.authBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.profileBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.jobPostBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.savedJobBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.jobApplicationBox);
  }

  Future<void> close() async {
    await Hive.close();
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }
}

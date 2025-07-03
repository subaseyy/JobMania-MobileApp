import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/core/network/api_service.dart';

import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

import 'package:jobmaniaapp/features/auth/presentation/view_model/otpverification_view_model/otpVerification_view_model.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
import 'package:jobmaniaapp/features/home/domain/use_case/get_few_jobs_usecase.dart';
import 'package:jobmaniaapp/features/home/presentation/view_model/dashboard_view_model.dart';
import 'package:jobmaniaapp/features/job/domain/repository/job_repository.dart';
import 'package:jobmaniaapp/features/job/domain/repository/job_repository_impl.dart';

import 'package:jobmaniaapp/features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initCore();
  await _initAuthModule();
  await _initJobModule();
  await _initProfileModule();
  await _initSavedJobsModule();
  await _initApplicationModule();
}

Future<void> _initHiveService() async {
  final hiveService = HiveService();
  await hiveService.init();
  serviceLocator.registerLazySingleton(() => hiveService);
}

Future<void> _initCore() async {
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton<ApiService>(
    () => ApiService(serviceLocator<Dio>()),
  );

  serviceLocator.registerLazySingleton(() => SplashViewModel());
}

Future<void> _initAuthModule() async {
  serviceLocator.registerFactory<LoginViewModel>(
    () => LoginViewModel(dio: serviceLocator<Dio>()),
  );

  serviceLocator.registerLazySingleton<OtpVerificationViewModel>(
    () => OtpVerificationViewModel(dio: serviceLocator<Dio>()),
  );

  serviceLocator.registerLazySingleton<SignupViewModel>(
    () => SignupViewModel(dio: serviceLocator<Dio>()),
  );
}

Future<void> _initJobModule() async {
  serviceLocator.registerLazySingleton<JobRepository>(
    () => JobRepositoryImpl(dio: serviceLocator()),
  );
  serviceLocator.registerFactory(() => GetFewJobsUseCase(serviceLocator()));
  serviceLocator.registerFactory(
    () => DashboardViewModel(getFewJobsUseCase: serviceLocator()),
  );
}

Future<void> _initProfileModule() async {
  // Register Profile-related services and VMs here
}

Future<void> _initSavedJobsModule() async {
  // Register SavedJobs-related services and VMs here
}

Future<void> _initApplicationModule() async {
  // Register Application-related services and VMs here
}

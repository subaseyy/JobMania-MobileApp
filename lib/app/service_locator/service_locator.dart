import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:jobmaniaapp/app/constants/api_endpoint.dart';

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
import 'package:jobmaniaapp/features/user/data/data_source/local_data_source/profile_local_datasource.dart';
import 'package:jobmaniaapp/features/user/data/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:jobmaniaapp/features/user/data/repository/local_repository/user_profile_local_repository_impl.dart';
import 'package:jobmaniaapp/features/user/data/repository/remote_datasource/user_profile_remote_repository_impl.dart';

import 'package:jobmaniaapp/features/user/domain/repository/user_profile_repository.dart';
import 'package:jobmaniaapp/features/user/domain/use_case/get_profile_use_case.dart';
import 'package:jobmaniaapp/features/user/presentation/view_model/profile_cubit.dart';
import 'package:jobmaniaapp/features/user/presentation/view_model/profile_view_model.dart';

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

  serviceLocator.registerFactory(
    () => SplashViewModel(hiveService: serviceLocator<HiveService>()),
  );
}

Future<void> _initAuthModule() async {
  serviceLocator.registerFactory<LoginViewModel>(
    () => LoginViewModel(
      dio: serviceLocator<Dio>(),
      hiveService: serviceLocator<HiveService>(),
    ),
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
    () => JobRepositoryImpl(dio: serviceLocator<Dio>()),
  );

  serviceLocator.registerFactory(
    () => GetFewJobsUseCase(serviceLocator<JobRepository>()),
  );

  serviceLocator.registerFactory(
    () => DashboardViewModel(
      getFewJobsUseCase: serviceLocator<GetFewJobsUseCase>(),
    ),
  );
}

Future<void> _initProfileModule() async {
  serviceLocator.registerLazySingleton(
    () => ProfileRemoteDataSource(dio: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(() => ProfileLocalDataSource());

  serviceLocator.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRemoteRepositoryImpl(remoteDataSource: serviceLocator()),
    instanceName: "remote",
  );

  serviceLocator.registerLazySingleton<UserProfileRepository>(
    () => UserProfileLocalRepositoryImpl(localDataSource: serviceLocator()),
    instanceName: "local",
  );

  serviceLocator.registerFactory(
    () => ProfileViewModel(
      remoteRepo: serviceLocator<UserProfileRepository>(instanceName: "remote"),
      localRepo: serviceLocator<UserProfileRepository>(instanceName: "local"),
    ),
  );
}

Future<void> _initSavedJobsModule() async {
  // Register saved jobs-related services/view models here
}

Future<void> _initApplicationModule() async {
  // Register job application-related services/view models here
}

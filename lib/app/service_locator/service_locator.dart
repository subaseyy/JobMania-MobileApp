import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/core/network/api_service.dart';

import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
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
  serviceLocator.registerLazySingleton(() => HiveService());
}

Future<void> _initCore() async {
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton<ApiService>(
    () => ApiService(serviceLocator<Dio>()),
  );

  // serviceLocator.registerLazySingleton<SplashViewModel>(
  //   () => SplashViewModel(),
  // );
}

Future<void> _initAuthModule() async {
  // serviceLocator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
}

Future<void> _initJobModule() async {
  // Register Job-related services and VMs here
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

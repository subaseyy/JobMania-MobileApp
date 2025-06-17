import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/core/network/api_service.dart';

// Import your modules here
// import 'package:jobmaniaapp/features/auth/...';
// import 'package:jobmaniaapp/features/job/...';

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

Future<void> _initCore() async {
  serviceLocator.registerLazySingleton(() => HiveService());
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => ApiService(serviceLocator<Dio>()));
}

Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton(() => HiveService());
}

Future<void> _initApplicationModule() async {}

Future<void> _initAuthModule() async {}

Future<void> _initJobModule() async {}

Future<void> _initProfileModule() async {}

Future<void> _initSavedJobsModule() async {}

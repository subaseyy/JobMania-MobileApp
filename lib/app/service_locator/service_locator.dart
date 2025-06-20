import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:jobmaniaapp/core/network/api_service.dart';

import 'package:jobmaniaapp/features/auth/data/repository/local_repository/auth_repository.dart';
import 'package:jobmaniaapp/features/auth/data/repository/local_repository/auth_repository_impl.dart';
import 'package:jobmaniaapp/features/auth/domain/use_case/register_usecase.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';

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

  await hiveService.init(); // This initializes Hive and registers adapters
  serviceLocator.registerLazySingleton(() => hiveService);
}

Future<void> _initCore() async {
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton<ApiService>(
    () => ApiService(serviceLocator<Dio>()),
  );

  serviceLocator.registerLazySingleton(
    () => SplashViewModel(hiveService: serviceLocator<HiveService>()),
  );
}

Future<void> _initAuthModule() async {
  serviceLocator.registerFactory<LoginViewModel>(
    () => LoginViewModel(LoginState.initial()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(hiveService: serviceLocator<HiveService>()),
  );

  serviceLocator.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(repository: serviceLocator<AuthRepository>()),
  );

  serviceLocator.registerFactory<SignupViewModel>(
    () => SignupViewModel(useCase: serviceLocator<RegisterUseCase>()),
  );
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

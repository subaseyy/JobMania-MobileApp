import 'package:get_it/get_it.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
import 'package:mocktail/mocktail.dart';

// GetIt instance
final sl = GetIt.instance;

// Mock classes for your view models
class MockLoginViewModel extends Mock implements LoginViewModel {}

class MockSignupViewModel extends Mock implements SignupViewModel {}

void setupTestDependencies() {
  sl.registerLazySingleton<LoginViewModel>(() => MockLoginViewModel());
  sl.registerLazySingleton<SignupViewModel>(() => MockSignupViewModel());
}

void resetTestDependencies() {
  sl.reset();
}

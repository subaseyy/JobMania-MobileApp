import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:jobmaniaapp/core/network/hive_services.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/login_view_model/login_state.dart';

class MockDio extends Mock implements Dio {}

class MockHiveService extends Mock implements HiveService {}

void main() {
  late MockDio mockDio;
  late MockHiveService mockHiveService;

  setUp(() {
    mockDio = MockDio();
    mockHiveService = MockHiveService();
  });

  blocTest<LoginViewModel, LoginState>(
    'Emits loading then success on valid login',
    build: () => LoginViewModel(dio: mockDio, hiveService: mockHiveService),
    act: (bloc) {
      var context = null;
      return bloc.add(
        LoginWithEmailAndPasswordEvent(
          context: context,
          username: 'test@test.com',
          password: 'password123',
        ),
      );
    },
    expect:
        () => [
          const LoginState(isLoading: true, isSuccess: false, message: ''),
          const LoginState(isLoading: false, isSuccess: true, message: ''),
        ],
  );
}

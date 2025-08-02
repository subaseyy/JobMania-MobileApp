import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:jobmaniaapp/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
import 'package:jobmaniaapp/features/auth/presentation/view/signup.view.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

// Mock Dio for SignupViewModel
class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
  });

  testWidgets('SignupView has Register button', (WidgetTester tester) async {
    // Provide SignupViewModel with mock Dio
    await tester.pumpWidget(
      Provider<SignupViewModel>(
        create: (_) => SignupViewModel(dio: mockDio),
        child: MaterialApp(home: SignupView()),
      ),
    );

    // Pump frame
    await tester.pump();

    // Check Register button is found
    expect(find.text('Register'), findsOneWidget);
  });
}

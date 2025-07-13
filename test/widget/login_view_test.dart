import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobmaniaapp/features/auth/presentation/view/login.view.dart';

import '../test_setup.dart';

void main() {
  setUpAll(() {
    setupTestDependencies();
  });

  tearDownAll(() {
    resetTestDependencies();
  });

  testWidgets('LoginView has Login button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    expect(find.text('Log in'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsWidgets);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobmaniaapp/features/auth/presentation/view/signup.view.dart';

import '../test_setup.dart';

void main() {
  setUpAll(() {
    setupTestDependencies();
  });

  tearDownAll(() {
    resetTestDependencies();
  });

  testWidgets('SignupView has Register button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupView()));

    expect(find.text('Register'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(4));
  });
}

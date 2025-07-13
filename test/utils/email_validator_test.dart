import 'package:flutter_test/flutter_test.dart';
import 'package:jobmaniaapp/core/utils/email_validator.dart';

void main() {
  test('Returns true for valid email', () {
    expect(isValidEmail('user@example.com'), true);
  });

  test('Returns false for invalid email', () {
    expect(isValidEmail('invalid_email'), false);
  });
}

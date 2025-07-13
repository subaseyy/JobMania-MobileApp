import 'package:flutter_test/flutter_test.dart';
import 'package:jobmaniaapp/core/utils/password_match.dart';

void main() {
  test('Passwords match returns true', () {
    expect(doPasswordsMatch('abc123', 'abc123'), true);
  });

  test('Passwords match returns false', () {
    expect(doPasswordsMatch('abc123', '123abc'), false);
  });
}

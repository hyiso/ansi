import 'package:ansi_strip/ansi_strip.dart';
import 'package:test/test.dart';

void main() {
  test('should strip ANSI escape codes from a string', () {
    final formattedString =
        '\x1B[31mError:\x1B[0m \x1B[33mSomething went wrong\x1B[0m';
    final expectedString = 'Error: Something went wrong';
    final strippedString = stripAnsi(formattedString);

    expect(strippedString, equals(expectedString));
  });

  test('should return the same string when no ANSI escape codes are present',
      () {
    final plainString = 'Hello, world!';
    final strippedString = stripAnsi(plainString);

    expect(strippedString, equals(plainString));
  });
}

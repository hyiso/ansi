import 'package:ansi_slice/ansi_slice.dart';
import 'package:test/test.dart';

void main() {
  test('should return the original string if no ANSI codes are used', () {
    expect(sliceAnsi('Hello world'), equals('Hello world'));
  });

  test('should remove ANSI color codes from a string', () {
    expect(sliceAnsi('\u001b[31mHello\u001b[32m \u001b[33mworld\u001b[0m'),
        equals('Hello world'));
  });

  test('should remove all ANSI escape sequences from a string', () {
    expect(sliceAnsi('\u001b[31mHello\u001b[1;32m \u001b[33mworld\u001b[0m\n'),
        equals('Hello world\n'));
  });
}

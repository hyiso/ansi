import 'package:test/test.dart';
import 'package:ansi/ansi.dart';

void main() {
  test('style string', () {
    expect(underline('foo'), '\u001B[4mfoo\u001B[24m');
    expect(red('foo'), '\u001B[31mfoo\u001B[39m');
    expect(bgRed('foo'), '\u001B[41mfoo\u001B[49m');
  });
}

import 'package:ansi/ansi.dart';
import 'package:test/test.dart';

void main() {
  group('stripAnsi', () {
    test('strip color from string', () {
      expect(stripAnsi('\u001B[0m\u001B[4m\u001B[42m\u001B[31mfoo\u001B[39m\u001B[49m\u001B[24mfoo\u001B[0m'), equals('foofoo'));
    });

    test('strip color from ls command', () {
      expect(stripAnsi('\u001B[00;38;5;244m\u001B[m\u001B[00;38;5;33mfoo\u001B[0m'), equals('foo'));
    });

    test('strip reset;setfg;setbg;italics;strike;underline sequence from string', () {
      expect(stripAnsi('\u001B[0;33;49;3;9;4mbar\u001B[0m'), equals('bar'));
    });

    test('strip link from terminal link', () {
      expect(stripAnsi('\u001B]8;;https://github.com\u0007click\u001B]8;;\u0007'), equals('click'));
    });
  });
}

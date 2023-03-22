import 'package:ansi_regex/ansi_regex.dart';
import 'package:test/test.dart';

void main() {
  final regex = ansiRegex();
  // Testing against codes found at: http://ascii-table.com/ansi-escape-sequences-vt-100.php
  test('match ansi code in a string', () {
    expect(regex.hasMatch('foo\u001B[4mcake\u001B[0m'), true);
    expect(regex.hasMatch('\u001B[4mcake\u001B[0m'), true);
    expect(regex.hasMatch('foo\u001B[4mcake\u001B[0m'), true);
    expect(
        regex.hasMatch(
            '\u001B[0m\u001B[4m\u001B[42m\u001B[31mfoo\u001B[39m\u001B[49m\u001B[24mfoo\u001B[0m'),
        true);
    expect(regex.hasMatch('foo\u001B[mfoo'), true);
  });

  test('match ansi code from ls command', () {
    expect(
        regex.hasMatch(
            '\u001B[00;38;5;244m\u001B[m\u001B[00;38;5;33mfoo\u001B[0m'),
        true);
  });

  test('match reset;setfg;setbg;italics;strike;underline sequence in a string',
      () {
    expect(regex.hasMatch('\u001B[0;33;49;3;9;4mbar\u001B[0m'), true);
    expect(regex.hasMatch('foo\u001B[0;33;49;3;9;4mbar'), true);
    expect(regex.firstMatch('foo\u001B[0;33;49;3;9;4mbar')?.group(0),
        '\u001B[0;33;49;3;9;4m');
  });

  test('match clear tabs sequence in a string', () {
    expect(regex.hasMatch('foo\u001B[0gbar'), true);
    expect(regex.firstMatch('foo\u001B[0gbar')?.group(0), '\u001B[0g');
  });

  test('match clear line from cursor right in a string', () {
    expect(regex.hasMatch('foo\u001B[Kbar'), true);
    expect(regex.firstMatch('foo\u001B[Kbar')?.group(0), '\u001B[K');
  });

  test('match clear screen in a string', () {
    expect(regex.hasMatch('foo\u001B[2Jbar'), true);
    expect(regex.firstMatch('foo\u001B[2Jbar')?.group(0), '\u001B[2J');
  });

  test('match terminal link', () {
    expect(
        regex.hasMatch(
            '\u001B]8;k=v;https://example-a.com/?a_b=1&c=2#tit%20le\u0007click\u001B]8;;\u0007'),
        true);
    expect(
        regex.hasMatch(
            '\u001B]8;;mailto:no-replay@mail.com\u0007mail\u001B]8;;\u0007'),
        true);
    expect(
        regex
            .allMatches(
                '\u001B]8;k=v;https://example-a.com/?a_b=1&c=2#tit%20le\u0007click\u001B]8;;\u0007')
            .map((match) => match.group(0)),
        [
          '\u001B]8;k=v;https://example-a.com/?a_b=1&c=2#tit%20le\u0007',
          '\u001B]8;;\u0007'
        ]);
    expect(
        regex
            .allMatches(
                '\u001B]8;;mailto:no-reply@mail.com\u0007mail-me\u001B]8;;\u0007')
            .map((match) => match.group(0)),
        ['\u001B]8;;mailto:no-reply@mail.com\u0007', '\u001B]8;;\u0007']);
  });

  test('match "change icon name and window title" in string', () {
    expect(
        regex
            .firstMatch(
                '\u001B]0;sg@tota:~/git/\u0007\u001B[01;32m[sg@tota\u001B[01;37m misc-tests\u001B[01;32m]')
            ?.group(0),
        '\u001B]0;sg@tota:~/git/\u0007');
  });
}

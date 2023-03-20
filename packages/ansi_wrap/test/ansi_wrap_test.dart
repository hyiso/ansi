import 'package:ansi/ansi.dart';
import 'package:ansi_regex/ansi_regex.dart';
import 'package:ansi_strip/ansi_strip.dart';
import 'package:ansi_wrap/ansi_wrap.dart';
import 'package:test/test.dart';

bool hasAnsi(String text) => ansiRegex().hasMatch(text);

void main() {
  final fixture = 'The quick brown ${ansi.red('fox jumped over ')}the lazy ${ansi.green('dog and then ran away with the unicorn.')}';
  final fixture2 = '12345678\n901234567890';
  final fixture3 = '12345678\n901234567890 12345';
  final fixture4 = '12345678\n';
  final fixture5 = '12345678\n ';

  test('wraps string at 20 characters', () {
    final result = wrapAnsi(fixture, 20);

    expect(result, 'The quick brown \u001B[31mfox\u001B[39m\n\u001B[31mjumped over \u001B[39mthe lazy\n\u001B[32mdog and then ran\u001B[39m\n\u001B[32maway with the\u001B[39m\n\u001B[32municorn.\u001B[39m');
    expect(true, stripAnsi(result).split('\n').every((line) => line.length <= 20));
  });

  test('wraps string at 30 characters', () {
    final result = wrapAnsi(fixture, 30);

    expect(result, 'The quick brown \u001B[31mfox jumped\u001B[39m\n\u001B[31mover \u001B[39mthe lazy \u001B[32mdog and then ran\u001B[39m\n\u001B[32maway with the unicorn.\u001B[39m');
    expect(true, stripAnsi(result).split('\n').every((line) => line.length <= 30));
  });

  test('does not break strings longer than "cols" characters', () {
    final result = wrapAnsi(fixture, 5, hard: false);

    expect(result, 'The\nquick\nbrown\n\u001B[31mfox\u001B[39m\n\u001B[31mjumped\u001B[39m\n\u001B[31mover\u001B[39m\n\u001B[31m\u001B[39mthe\nlazy\n\u001B[32mdog\u001B[39m\n\u001B[32mand\u001B[39m\n\u001B[32mthen\u001B[39m\n\u001B[32mran\u001B[39m\n\u001B[32maway\u001B[39m\n\u001B[32mwith\u001B[39m\n\u001B[32mthe\u001B[39m\n\u001B[32municorn.\u001B[39m');
    expect(true, stripAnsi(result).split('\n').any((line) => line.length > 5));
  });

  test('handles colored string that wraps on to multiple lines', () {
    final result = wrapAnsi('${ansi.green('hello world')} hey!', 5, hard: false);
    final lines = result.split('\n');
    expect(true, hasAnsi(lines[0]));
    expect(true, hasAnsi(lines[1]));
    expect(hasAnsi(lines[2]), false);
  });

  test('does not prepend newline if first string is greater than "cols"', () {
    final result = wrapAnsi('${ansi.green('hello')}-world', 5, hard: false);
    expect(result.split('\n').length, 1);
  });

  // When "hard" is true

  test('breaks strings longer than "cols" characters', () {
    final result = wrapAnsi(fixture, 5, hard: true);

    expect(result, 'The\nquick\nbrown\n\u001B[31mfox j\u001B[39m\n\u001B[31mumped\u001B[39m\n\u001B[31mover\u001B[39m\n\u001B[31m\u001B[39mthe\nlazy\n\u001B[32mdog\u001B[39m\n\u001B[32mand\u001B[39m\n\u001B[32mthen\u001B[39m\n\u001B[32mran\u001B[39m\n\u001B[32maway\u001B[39m\n\u001B[32mwith\u001B[39m\n\u001B[32mthe\u001B[39m\n\u001B[32munico\u001B[39m\n\u001B[32mrn.\u001B[39m');
    expect(true, stripAnsi(result).split('\n').every((line) => line.length <= 5));
  });

  test('removes last row if it contained only ansi escape codes', () {
    final result = wrapAnsi(ansi.green('helloworld'), 2, hard: true);
    expect(true, stripAnsi(result).split('\n').every((x) => x.length == 2));
  });

  test('does not prepend newline if first word is split', () {
    final result = wrapAnsi('${ansi.green('hello')}world', 5, hard: true);
    expect(result.split('\n').length, 2);
  });

  test('takes into account line returns inside input', () {
    expect(wrapAnsi(fixture2, 10, hard: true), '12345678\n9012345678\n90');
  });

  test('word wrapping', () {
    expect(wrapAnsi(fixture3, 15), '12345678\n901234567890\n12345');
  });

  test('no word-wrapping', () {
    final result = wrapAnsi(fixture3, 15, wordWrap: false);
    expect(result, '12345678\n901234567890 12\n345');

    final result2 = wrapAnsi(fixture3, 5, wordWrap: false);
    expect(result2, '12345\n678\n90123\n45678\n90 12\n345');

    final rsult3 = wrapAnsi(fixture5, 5, wordWrap: false);
    expect(rsult3, '12345\n678\n');

    final result4 = wrapAnsi(fixture, 5, wordWrap: false);
    expect(result4, 'The q\nuick\nbrown\n\u001B[31mfox j\u001B[39m\n\u001B[31mumped\u001B[39m\n\u001B[31mover\u001B[39m\n\u001B[31m\u001B[39mthe l\nazy \u001B[32md\u001B[39m\n\u001B[32mog an\u001B[39m\n\u001B[32md the\u001B[39m\n\u001B[32mn ran\u001B[39m\n\u001B[32maway\u001B[39m\n\u001B[32mwith\u001B[39m\n\u001B[32mthe u\u001B[39m\n\u001B[32mnicor\u001B[39m\n\u001B[32mn.\u001B[39m');
  });

  test('no word-wrapping and no trimming', () {
    final result = wrapAnsi(fixture3, 13, wordWrap: false, trim: false);
    expect(result, '12345678\n901234567890 \n12345');

    final result2 = wrapAnsi(fixture4, 5, wordWrap: false, trim: false);
    expect(result2, '12345\n678\n');

    final result3 = wrapAnsi(fixture5, 5, wordWrap: false, trim: false);
    expect(result3, '12345\n678\n ');

    final result4 = wrapAnsi(fixture, 5, wordWrap: false, trim: false);
    expect(result4, 'The q\nuick \nbrown\n \u001B[31mfox \u001B[39m\n[31mjumpe[39m\n[31md ove[39m\n[31mr \u001B[39mthe\n lazy\n \u001B[32mdog \u001B[39m\n[32mand t[39m\n[32mhen r[39m\n[32man aw[39m\n[32may wi[39m\n[32mth th[39m\n[32me uni[39m\n[32mcorn.\u001B[39m');
  });

  test('supports fullwidth characters', () {
    expect(wrapAnsi('안녕하세', 4, hard: true), '안녕\n하세');
  });

  test('supports unicode surrogate pairs', () {
    expect(wrapAnsi('a\uD83C\uDE00bc', 2, hard: true), 'a\n\uD83C\uDE00\nbc');
    expect(wrapAnsi('a\uD83C\uDE00bc\uD83C\uDE00d\uD83C\uDE00', 2, hard: true), 'a\n\uD83C\uDE00\nbc\n\uD83C\uDE00\nd\n\uD83C\uDE00');
  });

  test('#23, properly wraps whitespace with no trimming', () {
    expect(wrapAnsi('   ', 2, trim: false), '  \n ');
    expect(wrapAnsi('   ', 2, trim: false, hard: true), '  \n ');
  });

  test('#24, trims leading and trailing whitespace only on actual wrapped lines and only with trimming', () {
    expect(wrapAnsi('   foo   bar   ', 3), 'foo\nbar');
    expect(wrapAnsi('   foo   bar   ', 6), 'foo\nbar');
    expect(wrapAnsi('   foo   bar   ', 42), 'foo   bar');
    expect(wrapAnsi('   foo   bar   ', 42, trim: false), '   foo   bar   ');
  });

  test('#24, trims leading and trailing whitespace inside a color block only on actual wrapped lines and only with trimming', () {
    expect(wrapAnsi(ansi.blue('   foo   bar   '), 6), ansi.blue('foo\nbar'));
    expect(wrapAnsi(ansi.blue('   foo   bar   '), 42), ansi.blue('foo   bar'));
    expect(wrapAnsi(ansi.blue('   foo   bar   '), 42, trim: false), ansi.blue('   foo   bar   '));
  });

  test('#25, properly wraps whitespace between words with no trimming', () {
    expect(wrapAnsi('foo bar', 3), 'foo\nbar');
    expect(wrapAnsi('foo bar', 3, hard: true), 'foo\nbar');
    expect(wrapAnsi('foo bar', 3, trim: false), 'foo\n \nbar');
    expect(wrapAnsi('foo bar', 3, trim: false, hard: true), 'foo\n \nbar');
  });

  test('#26, does not multiplicate leading spaces with no trimming', () {
    expect(wrapAnsi(' a ', 10, trim: false), ' a ');
    expect(wrapAnsi('   a ', 10, trim: false), '   a ');
  });

  test('#27, does not remove spaces in line with ansi escapes when no trimming', () {
    expect(wrapAnsi(ansi.bgGreen(' ${ansi.black('OK')} '), 100, trim: false), ansi.bgGreen(' ${ansi.black('OK')} '));
    expect(wrapAnsi(ansi.bgGreen('  ${ansi.black('OK')} '), 100, trim: false), ansi.bgGreen('  ${ansi.black('OK')} '));
    expect(wrapAnsi(ansi.bgGreen(' hello '), 10, hard: true, trim: false), ansi.bgGreen(' hello '));
  });

  test('#35, wraps hyperlinks, preserving clickability in supporting terminals', () {
    final result1 = wrapAnsi('Check out \u001B]8;;https://www.example.com\u0007my website\u001B]8;;\u0007, it is \u001B]8;;https://www.example.com\u0007supercalifragilisticexpialidocious\u001B]8;;\u0007.', 16, hard: true);
    expect(result1, 'Check out \u001B]8;;https://www.example.com\u0007my\u001B]8;;\u0007\n\u001B]8;;https://www.example.com\u0007website\u001B]8;;\u0007, it is\n\u001B]8;;https://www.example.com\u0007supercalifragili\u001B]8;;\u0007\n\u001B]8;;https://www.example.com\u0007sticexpialidocio\u001B]8;;\u0007\n\u001B]8;;https://www.example.com\u0007us\u001B]8;;\u0007.');

    final result2 = wrapAnsi('Check out \u001B]8;;https://www.example.com\u0007my \uD83C\uDE00 ${ansi.bgGreen('website')}\u001B]8;;\u0007, it ${ansi.bgRed('is \u001B]8;;https://www.example.com\u0007super\uD83C\uDE00califragilisticexpialidocious\u001B]8;;\u0007')}.', 16, hard: true);
    expect(result2, 'Check out \u001B]8;;https://www.example.com\u0007my 🈀\u001B]8;;\u0007\n\u001B]8;;https://www.example.com\u0007\u001B[42mwebsite\u001B[49m\u001B]8;;\u0007, it \u001B[41mis\u001B[49m\n\u001B[41m\u001B]8;;https://www.example.com\u0007super🈀califragi\u001B]8;;\u0007\u001B[49m\n\u001B[41m\u001B]8;;https://www.example.com\u0007listicexpialidoc\u001B]8;;\u0007\u001B[49m\n\u001B[41m\u001B]8;;https://www.example.com\u0007ious\u001B]8;;\u0007\u001B[49m.');
  });

  test('covers non-SGR/non-hyperlink ansi escapes', () {
    expect(wrapAnsi('Hello, \u001B[1D World!', 8), 'Hello,\u001B[1D\nWorld!');
    expect(wrapAnsi('Hello, \u001B[1D World!', 8, trim: false), 'Hello, \u001B[1D \nWorld!');
  });

  test('#39, normalizes newlines', () {
    expect(wrapAnsi('foobar\r\nfoobar\r\nfoobar\nfoobar', 3, hard: true), 'foo\nbar\nfoo\nbar\nfoo\nbar\nfoo\nbar');
    expect(wrapAnsi('foo bar\r\nfoo bar\r\nfoo bar\nfoo bar', 3), 'foo\nbar\nfoo\nbar\nfoo\nbar\nfoo\nbar');
  });
}

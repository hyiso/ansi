import 'dart:convert';

import 'package:ansi/ansi.dart';
import 'package:ansi/src/slice.dart';
import 'package:ansi_styles/ansi_styles.dart';
import 'package:test/test.dart';

void main() {
  final fixture = AnsiStyles.red('the ') + AnsiStyles.green('quick ') + AnsiStyles.blue('brown ') + AnsiStyles.cyan('fox ') + AnsiStyles.yellow('jumped ');
  final stripped = stripAnsi(fixture);
  test('main', () {
	// The slice should behave exactly as a regular JS slice behaves
	for (var index = 0; index < 20; index++) {
		for (var index2 = 19; index2 > index; index2--) {
			var nativeSlice = stripped.substring(index, index2);
			var ansiSlice = sliceAnsi(fixture, index, index2);
			expect(nativeSlice, stripAnsi(ansiSlice));
		}
	}

	var a = jsonEncode('\u001B[31mthe \u001B[39m\u001B[32mquick \u001B[39m');
	var b = jsonEncode('\u001B[34mbrown \u001B[39m\u001B[36mfox \u001B[39m');
	var c = jsonEncode('\u001B[31m \u001B[39m\u001B[32mquick \u001B[39m\u001B[34mbrown \u001B[39m\u001B[36mfox \u001B[39m');

	expect(jsonEncode(sliceAnsi(fixture, 0, 10)), a);
	expect(jsonEncode(sliceAnsi(fixture, 10, 20)), b);
	expect(jsonEncode(sliceAnsi(fixture, 3, 20)), c);
});

test('supports fullwidth characters', () {
	expect(sliceAnsi('안녕하세', 0, 4), '안녕');
});

test('supports unicode surrogate pairs', () {
	expect(sliceAnsi('a\uD83C\uDE00BC', 0, 2), 'a\uD83C\uDE00');
});

test('doesn\'t add unnecessary escape codes', () {
	expect(sliceAnsi('\u001B[31municorn\u001B[39m', 0, 3), '\u001B[31muni\u001B[39m');
});

test('can slice a normal character before a colored character', () {
	expect(sliceAnsi('a\u001B[31mb\u001B[39m', 0, 1), 'a');
});

test('can slice a normal character after a colored character', () {
	expect(sliceAnsi('\u001B[31ma\u001B[39mb', 1, 2), 'b');
});

// See https://github.com/AnsiStyles/slice-ansi/issues/22
test('can slice a string styled with both background and foreground', () {
	// Test string: 'AnsiStyles.bgGreen.black('test');'
	expect(sliceAnsi('\u001B[42m\u001B[30mtest\u001B[39m\u001B[49m', 0, 1), '\u001B[42m\u001B[30mt\u001B[39m\u001B[49m');
});

test('can slice a string styled with modifier', () {
	// Test string: 'AnsiStyles.underline('test');'
	expect(sliceAnsi('\u001B[4mtest\u001B[24m', 0, 1), '\u001B[4mt\u001B[24m');
});

test('can slice a string with unknown ANSI color', () {
	expect(sliceAnsi('\u001B[20mTEST\u001B[49m', 0, 4), '\u001B[20mTEST\u001B[0m');
	expect(sliceAnsi('\u001B[1001mTEST\u001B[49m', 0, 3), '\u001B[1001mTES\u001B[0m');
	expect(sliceAnsi('\u001B[1001mTEST\u001B[49m', 0, 2), '\u001B[1001mTE\u001B[0m');
});

test('weird null issue', () {
	var s = '\u001B[1mautotune.flipCoin("easy as") ? 🎂 : 🍰 \u001B[33m★\u001B[39m\u001B[22m';
	var result = sliceAnsi(s, 38);
	expect(result.contains('null'), false);
});

test('support true color escape sequences', () {
	expect(sliceAnsi('\u001B[1m\u001B[48;2;255;255;255m\u001B[38;2;255;0;0municorn\u001B[39m\u001B[49m\u001B[22m', 0, 3), '\u001B[1m\u001B[48;2;255;255;255m\u001B[38;2;255;0;0muni\u001B[22m\u001B[49m\u001B[39m');
});

// See https://github.com/AnsiStyles/slice-ansi/issues/24
test('doesn\'t add extra escapes', () {
	var output = '${AnsiStyles.black.bgYellow(' RUNS ')}  ${AnsiStyles.green('test')}';
	expect(sliceAnsi(output, 0, 7), '${AnsiStyles.black.bgYellow(' RUNS ')} ');
	expect(sliceAnsi(output, 0, 8), '${AnsiStyles.black.bgYellow(' RUNS ')}  ');
	expect(jsonEncode(sliceAnsi('\u001B[31m' + output, 0, 4)),jsonEncode('\u001B[31m${AnsiStyles.black.bgYellow(' RUN')}'));
});

// See https://github.com/AnsiStyles/slice-ansi/issues/26
test('does not lose fullwidth characters', () {
	expect(sliceAnsi('古古test', 0), '古古test');
});

test('slice links', () {
	var link = '\u001B]8;;https://google.com\u0007Google\u001B]8;;\u0007';
	expect(sliceAnsi(link, 0, 6), link);
});
}
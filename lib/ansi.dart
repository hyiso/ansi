import 'dart:io';

import 'dart:math';

const _kEscape = '\x1B[';
class Ansi {

  static String reset() => _code(0);
  static String bold(String text) => '${_code(1)}$text${reset()}';
  static String dim(String text) => '${_code(2)}$text${reset()}';
  static String italic(String text) => '${_code(3)}$text${reset()}';
  static String underline(String text) => '${_code(4)}$text${reset()}';
  static String inverse(String text) => '${_code(7)}$text${reset()}';

  static String black(String text) => '${_code(30)}$text${reset()}';
  static String red(String text) => '${_code(31)}$text${reset()}';
  static String green(String text) => '${_code(32)}$text${reset()}';
  static String yellow(String text) => '${_code(33)}$text${reset()}';
  static String blue(String text) => '${_code(34)}$text${reset()}';
  static String magenta(String text) => '${_code(35)}$text${reset()}';
  static String cyan(String text) => '${_code(36)}$text${reset()}';
  static String white(String text) => '${_code(37)}$text${reset()}';

  static String bgBlack(String text) => '${_code(40)}$text${reset()}';
  static String bgRed(String text) => '${_code(41)}$text${reset()}';
  static String bgGreen(String text) => '${_code(42)}$text${reset()}';
  static String bgYellow(String text) => '${_code(43)}$text${reset()}';
  static String bgBlue(String text) => '${_code(44)}$text${reset()}';
  static String bgMagenta(String text) => '${_code(45)}$text${reset()}';
  static String bgCyan(String text) => '${_code(46)}$text${reset()}';
  static String bgWhite(String text) => '${_code(47)}$text${reset()}';

  static String _code(int code) => stdout.supportsAnsiEscapes && stdioType(stdout) == StdioType.terminal ? '$_kEscape${code}m' : '';
}

String sliceAnsi(String text, {int start = 0, int? end}) {
  end ??= text.length;
  final pattern = RegExp('\x1B\\[[0-9;]*m');
  final buffer = StringBuffer();
  var skip = 0;
  for (var i = 0; i < text.length; i++) {
    final char = text[i];
    if (char == '\x1B') {
      final match = pattern.matchAsPrefix(text.substring(i));
      if (match != null) {
        i += match.end - match.start - 1;
        continue;
      }
    }
    if (skip > 0) {
      skip--;
      continue;
    }
    if (buffer.length >= end) {
      break;
    }
    if (buffer.length >= start) {
      buffer.write(char);
    }
  }
  return buffer.toString();
}

String stripAnsi(String text) {
  return text.replaceAll(RegExp('\x1B\\[[0-9;]+m', multiLine: true), '');
}

import 'dart:io';

const _kEscape = '\x1B[';

///
/// Ansi class
/// 
class Ansi {

  final bool supportAnsi;

  Ansi({this.supportAnsi = true});

  String reset() => _code(0);
  String bold(String text) => '${_code(1)}$text${reset()}';
  String dim(String text) => '${_code(2)}$text${reset()}';
  String italic(String text) => '${_code(3)}$text${reset()}';
  String underline(String text) => '${_code(4)}$text${reset()}';
  String inverse(String text) => '${_code(7)}$text${reset()}';

  String black(String text) => '${_code(30)}$text${reset()}';
  String red(String text) => '${_code(31)}$text${reset()}';
  String green(String text) => '${_code(32)}$text${reset()}';
  String yellow(String text) => '${_code(33)}$text${reset()}';
  String blue(String text) => '${_code(34)}$text${reset()}';
  String magenta(String text) => '${_code(35)}$text${reset()}';
  String cyan(String text) => '${_code(36)}$text${reset()}';
  String white(String text) => '${_code(37)}$text${reset()}';

  String bgBlack(String text) => '${_code(40)}$text${reset()}';
  String bgRed(String text) => '${_code(41)}$text${reset()}';
  String bgGreen(String text) => '${_code(42)}$text${reset()}';
  String bgYellow(String text) => '${_code(43)}$text${reset()}';
  String bgBlue(String text) => '${_code(44)}$text${reset()}';
  String bgMagenta(String text) => '${_code(45)}$text${reset()}';
  String bgCyan(String text) => '${_code(46)}$text${reset()}';
  String bgWhite(String text) => '${_code(47)}$text${reset()}';

  String _code(int code) => supportAnsi ? '$_kEscape${code}m' : '';
}

///
/// Default ansi entry.
/// Auto detect ansi support.
/// 
final ansi = Ansi(supportAnsi: stdout.supportsAnsiEscapes && stdioType(stdout) == StdioType.terminal);

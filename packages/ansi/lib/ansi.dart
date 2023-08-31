import 'dart:io';

import 'src/style.dart' as style;

export 'src/extension.dart';
export 'src/style.dart';

///
/// Ansi class
///
@Deprecated('Use style method or AnsiString extension instead')
class Ansi {
  final bool supportAnsi;

  Ansi({this.supportAnsi = true});

  String reset(String text) => style.reset(text);
  String bold(String text) => style.bold(text);
  String dim(String text) => style.dim(text);
  String italic(String text) => style.italic(text);
  String underline(String text) => style.underline(text);
  String inverse(String text) => style.inverse(text);
  String hidden(String text) => style.hidden(text);
  String strikeThrough(String text) => style.strikeThrough(text);

  String black(String text) => style.black(text);
  String red(String text) => style.red(text);
  String green(String text) => style.green(text);
  String yellow(String text) => style.yellow(text);
  String blue(String text) => style.blue(text);
  String magenta(String text) => style.magenta(text);
  String cyan(String text) => style.cyan(text);
  String white(String text) => style.white(text);
  String blackBright(String text) => style.blackBright(text);
  String redBright(String text) => style.redBright(text);
  String greenBright(String text) => style.greenBright(text);
  String yellowBright(String text) => style.yellowBright(text);
  String blueBright(String text) => style.blueBright(text);
  String magentaBright(String text) => style.magentaBright(text);
  String cyanBright(String text) => style.cyanBright(text);
  String whiteBright(String text) => style.whiteBright(text);
  String grey(String text) => style.grey(text);
  String gray(String text) => style.gray(text);

  String bgBlack(String text) => style.bgBlack(text);
  String bgRed(String text) => style.bgRed(text);
  String bgGreen(String text) => style.bgGreen(text);
  String bgYellow(String text) => style.bgYellow(text);
  String bgBlue(String text) => style.bgBlue(text);
  String bgMagenta(String text) => style.bgMagenta(text);
  String bgCyan(String text) => style.bgCyan(text);
  String bgWhite(String text) => style.bgWhite(text);
  String bgBlackBright(String text) => style.bgBlackBright(text);
  String bgRedBright(String text) => style.bgRedBright(text);
  String bgGreenBright(String text) => style.bgGreenBright(text);
  String bgYellowBright(String text) => style.bgYellowBright(text);
  String bgBlueBright(String text) => style.bgBlueBright(text);
  String bgMagentaBright(String text) => style.bgMagentaBright(text);
  String bgCyanBright(String text) => style.bgCyanBright(text);
  String bgWhiteBright(String text) => style.bgWhiteBright(text);
}

///
/// Default ansi entry.
/// Auto detect ansi support.
///
@Deprecated('Use style method or AnsiString extension instead')
final ansi = Ansi(
    supportAnsi:
        stdout.supportsAnsiEscapes && stdioType(stdout) == StdioType.terminal);

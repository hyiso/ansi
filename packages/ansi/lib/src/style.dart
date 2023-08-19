import 'dart:io';

import 'package:ansi_codes/ansi_codes.dart';
import 'utils.dart';

bool get _supportAnsi =>
    stdout.supportsAnsiEscapes && stdioType(stdout) == StdioType.terminal;

String reset(String text) => _style(text, ansiCodes.reset);
String bold(String text) => _style(text, ansiCodes.bold);
String dim(String text) => _style(text, ansiCodes.dim);
String italic(String text) => _style(text, ansiCodes.italic);
String underline(String text) => _style(text, ansiCodes.underline);
String inverse(String text) => _style(text, ansiCodes.inverse);
String hidden(String text) => _style(text, ansiCodes.hidden);
String strikeThrough(String text) => _style(text, ansiCodes.strikeThrough);

String black(String text) => _style(text, ansiCodes.black);
String red(String text) => _style(text, ansiCodes.red);
String green(String text) => _style(text, ansiCodes.green);
String yellow(String text) => _style(text, ansiCodes.yellow);
String blue(String text) => _style(text, ansiCodes.blue);
String magenta(String text) => _style(text, ansiCodes.magenta);
String cyan(String text) => _style(text, ansiCodes.cyan);
String white(String text) => _style(text, ansiCodes.white);
String blackBright(String text) => _style(text, ansiCodes.blackBright);
String redBright(String text) => _style(text, ansiCodes.redBright);
String greenBright(String text) => _style(text, ansiCodes.greenBright);
String yellowBright(String text) => _style(text, ansiCodes.yellowBright);
String blueBright(String text) => _style(text, ansiCodes.blueBright);
String magentaBright(String text) => _style(text, ansiCodes.magentaBright);
String cyanBright(String text) => _style(text, ansiCodes.cyanBright);
String whiteBright(String text) => _style(text, ansiCodes.whiteBright);
String grey(String text) => _style(text, ansiCodes.grey);
String gray(String text) => _style(text, ansiCodes.gray);

String bgBlack(String text) => _style(text, ansiCodes.bgBlack);
String bgRed(String text) => _style(text, ansiCodes.bgRed);
String bgGreen(String text) => _style(text, ansiCodes.bgGreen);
String bgYellow(String text) => _style(text, ansiCodes.bgYellow);
String bgBlue(String text) => _style(text, ansiCodes.bgBlue);
String bgMagenta(String text) => _style(text, ansiCodes.bgMagenta);
String bgCyan(String text) => _style(text, ansiCodes.bgCyan);
String bgWhite(String text) => _style(text, ansiCodes.bgWhite);
String bgBlackBright(String text) => _style(text, ansiCodes.bgBlackBright);
String bgRedBright(String text) => _style(text, ansiCodes.bgRedBright);
String bgGreenBright(String text) => _style(text, ansiCodes.bgGreenBright);
String bgYellowBright(String text) => _style(text, ansiCodes.bgYellowBright);
String bgBlueBright(String text) => _style(text, ansiCodes.bgBlueBright);
String bgMagentaBright(String text) => _style(text, ansiCodes.bgMagentaBright);
String bgCyanBright(String text) => _style(text, ansiCodes.bgCyanBright);
String bgWhiteBright(String text) => _style(text, ansiCodes.bgWhiteBright);

String _style(String text, AnsiCode code) {
  if (!_supportAnsi) return text;
  if (text.contains('\u001B')) {
    text = stringReplaceAll(text, code.close, code.open);
  }
  int index = text.indexOf('\n');
  if (index != -1) {
    text = stringEncaseCRLFWithFirstIndex(text, code.close, code.open, index);
  }
  return [
    code.open,
    text,
    code.close,
  ].join('');
}

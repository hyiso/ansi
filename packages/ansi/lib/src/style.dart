import 'dart:io';

import 'package:ansi_codes/ansi_codes.dart';
import 'utils.dart';

bool get _isTest =>
    Platform.script.path.split('/').last.startsWith('test.dart');

bool get _supportAnsi =>
    stdout.supportsAnsiEscapes && stdioType(stdout) == StdioType.terminal;

/// rest style
String reset(String text) => _style(text, ansiCodes.reset);

/// bold style
String bold(String text) => _style(text, ansiCodes.bold);

/// dim style
String dim(String text) => _style(text, ansiCodes.dim);

/// italic style
String italic(String text) => _style(text, ansiCodes.italic);

/// underline style
String underline(String text) => _style(text, ansiCodes.underline);

/// inverse style
String inverse(String text) => _style(text, ansiCodes.inverse);

/// hidden style
String hidden(String text) => _style(text, ansiCodes.hidden);

/// strikethrough style
String strikeThrough(String text) => _style(text, ansiCodes.strikeThrough);

/// black style
String black(String text) => _style(text, ansiCodes.black);

/// red style
String red(String text) => _style(text, ansiCodes.red);

/// green style
String green(String text) => _style(text, ansiCodes.green);

/// yellow style
String yellow(String text) => _style(text, ansiCodes.yellow);

/// blue style
String blue(String text) => _style(text, ansiCodes.blue);

/// magenta style
String magenta(String text) => _style(text, ansiCodes.magenta);

/// cyan style
String cyan(String text) => _style(text, ansiCodes.cyan);

/// white style
String white(String text) => _style(text, ansiCodes.white);

/// blackBright style
String blackBright(String text) => _style(text, ansiCodes.blackBright);

/// redBright style
String redBright(String text) => _style(text, ansiCodes.redBright);

/// greenBright style
String greenBright(String text) => _style(text, ansiCodes.greenBright);

/// yellowBright style
String yellowBright(String text) => _style(text, ansiCodes.yellowBright);

/// blueBright style
String blueBright(String text) => _style(text, ansiCodes.blueBright);

/// magentaBright style
String magentaBright(String text) => _style(text, ansiCodes.magentaBright);

/// cyanBright style
String cyanBright(String text) => _style(text, ansiCodes.cyanBright);

/// whiteBright style
String whiteBright(String text) => _style(text, ansiCodes.whiteBright);

/// gray style
String grey(String text) => _style(text, ansiCodes.grey);

/// gray style
String gray(String text) => _style(text, ansiCodes.gray);

/// bgBlack style
String bgBlack(String text) => _style(text, ansiCodes.bgBlack);

/// bgRed style
String bgRed(String text) => _style(text, ansiCodes.bgRed);

/// bgGreen style
String bgGreen(String text) => _style(text, ansiCodes.bgGreen);

/// bgYellow style
String bgYellow(String text) => _style(text, ansiCodes.bgYellow);

/// bgBlue style
String bgBlue(String text) => _style(text, ansiCodes.bgBlue);

/// bgMagenta style
String bgMagenta(String text) => _style(text, ansiCodes.bgMagenta);

/// bgCyan style
String bgCyan(String text) => _style(text, ansiCodes.bgCyan);

/// bgWhite style
String bgWhite(String text) => _style(text, ansiCodes.bgWhite);

/// bgBlackBright style
String bgBlackBright(String text) => _style(text, ansiCodes.bgBlackBright);

/// bgRedBright style
String bgRedBright(String text) => _style(text, ansiCodes.bgRedBright);

/// bgGreenBright style
String bgGreenBright(String text) => _style(text, ansiCodes.bgGreenBright);

/// bgYellowBright style
String bgYellowBright(String text) => _style(text, ansiCodes.bgYellowBright);

/// bgBlueBright style
String bgBlueBright(String text) => _style(text, ansiCodes.bgBlueBright);

/// bgMagentaBright style
String bgMagentaBright(String text) => _style(text, ansiCodes.bgMagentaBright);

/// bgCyanBright style
String bgCyanBright(String text) => _style(text, ansiCodes.bgCyanBright);

/// bgWhiteBright style
String bgWhiteBright(String text) => _style(text, ansiCodes.bgWhiteBright);

String _style(String text, AnsiCode code) {
  if (!_supportAnsi && !_isTest) return text;
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

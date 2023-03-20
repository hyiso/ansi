import 'dart:io';

import 'package:ansi/src/utils.dart';
import 'package:ansi_codes/ansi_codes.dart';

///
/// Ansi class
/// 
class Ansi {

  final bool supportAnsi;

  Ansi({this.supportAnsi = true});

  String reset(String text) => _style(text: text, code: ansiCodes.reset);
  String bold(String text) => _style(text: text, code: ansiCodes.bold);
  String dim(String text) => _style(text: text, code: ansiCodes.dim);
  String italic(String text) => _style(text: text, code: ansiCodes.italic);
  String underline(String text) => _style(text: text, code: ansiCodes.underline);
  String inverse(String text) => _style(text: text, code: ansiCodes.inverse);
  String hidden(String text) => _style(text: text, code: ansiCodes.hidden);
  String strikeThrough(String text) => _style(text: text, code: ansiCodes.strikeThrough);

  String black(String text) => _style(text: text, code: ansiCodes.black);
  String red(String text) => _style(text: text, code: ansiCodes.red);
  String green(String text) => _style(text: text, code: ansiCodes.green);
  String yellow(String text) => _style(text: text, code: ansiCodes.yellow);
  String blue(String text) => _style(text: text, code: ansiCodes.blue);
  String magenta(String text) => _style(text: text, code: ansiCodes.magenta);
  String cyan(String text) => _style(text: text, code: ansiCodes.cyan);
  String white(String text) => _style(text: text, code: ansiCodes.white);
  String blackBright(String text) => _style(text: text, code: ansiCodes.blackBright);
  String redBright(String text) => _style(text: text, code: ansiCodes.redBright);
  String greenBright(String text) => _style(text: text, code: ansiCodes.greenBright);
  String yellowBright(String text) => _style(text: text, code: ansiCodes.yellowBright);
  String blueBright(String text) => _style(text: text, code: ansiCodes.blueBright);
  String magentaBright(String text) => _style(text: text, code: ansiCodes.magentaBright);
  String cyanBright(String text) => _style(text: text, code: ansiCodes.cyanBright);
  String whiteBright(String text) => _style(text: text, code: ansiCodes.whiteBright);
  String grey(String text) => _style(text: text, code: ansiCodes.grey);
  String gray(String text) => _style(text: text, code: ansiCodes.gray);

  String bgBlack(String text) => _style(text: text, code: ansiCodes.bgBlack);
  String bgRed(String text) => _style(text: text, code: ansiCodes.bgRed);
  String bgGreen(String text) => _style(text: text, code: ansiCodes.bgGreen);
  String bgYellow(String text) => _style(text: text, code: ansiCodes.bgYellow);
  String bgBlue(String text) => _style(text: text, code: ansiCodes.bgBlue);
  String bgMagenta(String text) => _style(text: text, code: ansiCodes.bgMagenta);
  String bgCyan(String text) => _style(text: text, code: ansiCodes.bgCyan);
  String bgWhite(String text) => _style(text: text, code: ansiCodes.bgWhite);
  String bgBlackBright(String text) => _style(text: text, code: ansiCodes.bgBlackBright);
  String bgRedBright(String text) => _style(text: text, code: ansiCodes.bgRedBright);
  String bgGreenBright(String text) => _style(text: text, code: ansiCodes.bgGreenBright);
  String bgYellowBright(String text) => _style(text: text, code: ansiCodes.bgYellowBright);
  String bgBlueBright(String text) => _style(text: text, code: ansiCodes.bgBlueBright);
  String bgMagentaBright(String text) => _style(text: text, code: ansiCodes.bgMagentaBright);
  String bgCyanBright(String text) => _style(text: text, code: ansiCodes.bgCyanBright);
  String bgWhiteBright(String text) => _style(text: text, code: ansiCodes.bgWhiteBright);

  String _style({required String text, required AnsiCode code}) {
    if (!supportAnsi) return text;
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
}

///
/// Default ansi entry.
/// Auto detect ansi support.
/// 
final ansi = Ansi(supportAnsi: stdout.supportsAnsiEscapes && stdioType(stdout) == StdioType.terminal);

import 'dart:io';

import 'utils.dart';

bool get _isTest =>
    Platform.script.path.split('/').last.startsWith('test.dart');

bool get _supportAnsi =>
    stdout.supportsAnsiEscapes && stdioType(stdout) == StdioType.terminal;

/// Motifiers
/// rest style
String reset(String text) => _style(0, 0).apply(text);

/// bold style
String bold(String text) => _style(1, 22).apply(text);

/// dim style
String dim(String text) => _style(2, 22).apply(text);

/// italic style
String italic(String text) => _style(3, 23).apply(text);

/// underline style
String underline(String text) => _style(4, 24).apply(text);

/// underline style
String overline(String text) => _style(53, 55).apply(text);

/// inverse style
String inverse(String text) => _style(7, 27).apply(text);

/// hidden style
String hidden(String text) => _style(8, 28).apply(text);

/// strikethrough style
String strikeThrough(String text) => _style(9, 29).apply(text);

/// Colors
/// black style
String black(String text) => _style(30, 39).apply(text);

/// red style
String red(String text) => _style(31, 39).apply(text);

/// green style
String green(String text) => _style(32, 39).apply(text);

/// yellow style
String yellow(String text) => _style(33, 39).apply(text);

/// blue style
String blue(String text) => _style(34, 39).apply(text);

/// magenta style
String magenta(String text) => _style(35, 39).apply(text);

/// cyan style
String cyan(String text) => _style(36, 39).apply(text);

/// white style
String white(String text) => _style(37, 39).apply(text);

/// blackBright style
String blackBright(String text) => _style(90, 39).apply(text);

/// redBright style
String redBright(String text) => _style(91, 39).apply(text);

/// greenBright style
String greenBright(String text) => _style(92, 39).apply(text);

/// yellowBright style
String yellowBright(String text) => _style(93, 39).apply(text);

/// blueBright style
String blueBright(String text) => _style(94, 39).apply(text);

/// magentaBright style
String magentaBright(String text) => _style(95, 39).apply(text);

/// cyanBright style
String cyanBright(String text) => _style(96, 39).apply(text);

/// whiteBright style
String whiteBright(String text) => _style(97, 39).apply(text);

/// gray style
String grey(String text) => blackBright(text);

/// gray style
String gray(String text) => blackBright(text);

/// Background Colors
/// bgBlack style
String bgBlack(String text) => _style(40, 49).apply(text);

/// bgRed style
String bgRed(String text) => _style(41, 49).apply(text);

/// bgGreen style
String bgGreen(String text) => _style(42, 49).apply(text);

/// bgYellow style
String bgYellow(String text) => _style(43, 49).apply(text);

/// bgBlue style
String bgBlue(String text) => _style(44, 49).apply(text);

/// bgMagenta style
String bgMagenta(String text) => _style(45, 49).apply(text);

/// bgCyan style
String bgCyan(String text) => _style(46, 49).apply(text);

/// bgWhite style
String bgWhite(String text) => _style(47, 49).apply(text);

/// bgBlackBright style
String bgBlackBright(String text) => _style(100, 49).apply(text);

/// bgRedBright style
String bgRedBright(String text) => _style(101, 49).apply(text);

/// bgGreenBright style
String bgGreenBright(String text) => _style(102, 49).apply(text);

/// bgYellowBright style
String bgYellowBright(String text) => _style(103, 49).apply(text);

/// bgBlueBright style
String bgBlueBright(String text) => _style(104, 49).apply(text);

/// bgMagentaBright style
String bgMagentaBright(String text) => _style(105, 49).apply(text);

/// bgCyanBright style
String bgCyanBright(String text) => _style(106, 49).apply(text);

/// bgWhiteBright style
String bgWhiteBright(String text) => _style(107, 49).apply(text);

_Style _style(int open, int close) {
  return _Style('\u001B[${open}m', '\u001B[${close}m');
}

class _Style {
  const _Style(this.open, this.close);

  final String open;
  final String close;

  String apply(String text) {
    if (!_supportAnsi && !_isTest) return text;
    if (text.contains('\u001B')) {
      text = stringReplaceAll(text, close, open);
    }
    int index = text.indexOf('\n');
    if (index != -1) {
      text = stringEncaseCRLFWithFirstIndex(text, close, open, index);
    }
    return [
      open,
      text,
      close,
    ].join('');
  }
}

import 'dart:io';

import 'utils.dart';

bool get _isTest =>
    Platform.script.path.split('/').last.startsWith('test.dart');

bool get _supportAnsi =>
    stdout.supportsAnsiEscapes && stdioType(stdout) == StdioType.terminal;

/// Motifiers
/// rest style
String reset(Object text) => _style(0, 0).apply(text);

/// bold style
String bold(Object text) => _style(1, 22).apply(text);

/// dim style
String dim(Object text) => _style(2, 22).apply(text);

/// italic style
String italic(Object text) => _style(3, 23).apply(text);

/// underline style
String underline(Object text) => _style(4, 24).apply(text);

/// underline style
String overline(Object text) => _style(53, 55).apply(text);

/// inverse style
String inverse(Object text) => _style(7, 27).apply(text);

/// hidden style
String hidden(Object text) => _style(8, 28).apply(text);

/// strikethrough style
String strikeThrough(Object text) => _style(9, 29).apply(text);

/// Colors
/// black style
String black(Object text) => _style(30, 39).apply(text);

/// red style
String red(Object text) => _style(31, 39).apply(text);

/// green style
String green(Object text) => _style(32, 39).apply(text);

/// yellow style
String yellow(Object text) => _style(33, 39).apply(text);

/// blue style
String blue(Object text) => _style(34, 39).apply(text);

/// magenta style
String magenta(Object text) => _style(35, 39).apply(text);

/// cyan style
String cyan(Object text) => _style(36, 39).apply(text);

/// white style
String white(Object text) => _style(37, 39).apply(text);

/// blackBright style
String blackBright(Object text) => _style(90, 39).apply(text);

/// redBright style
String redBright(Object text) => _style(91, 39).apply(text);

/// greenBright style
String greenBright(Object text) => _style(92, 39).apply(text);

/// yellowBright style
String yellowBright(Object text) => _style(93, 39).apply(text);

/// blueBright style
String blueBright(Object text) => _style(94, 39).apply(text);

/// magentaBright style
String magentaBright(Object text) => _style(95, 39).apply(text);

/// cyanBright style
String cyanBright(Object text) => _style(96, 39).apply(text);

/// whiteBright style
String whiteBright(Object text) => _style(97, 39).apply(text);

/// gray style
String grey(Object text) => blackBright(text);

/// gray style
String gray(Object text) => blackBright(text);

/// Background Colors
/// bgBlack style
String bgBlack(Object text) => _style(40, 49).apply(text);

/// bgRed style
String bgRed(Object text) => _style(41, 49).apply(text);

/// bgGreen style
String bgGreen(Object text) => _style(42, 49).apply(text);

/// bgYellow style
String bgYellow(Object text) => _style(43, 49).apply(text);

/// bgBlue style
String bgBlue(Object text) => _style(44, 49).apply(text);

/// bgMagenta style
String bgMagenta(Object text) => _style(45, 49).apply(text);

/// bgCyan style
String bgCyan(Object text) => _style(46, 49).apply(text);

/// bgWhite style
String bgWhite(Object text) => _style(47, 49).apply(text);

/// bgBlackBright style
String bgBlackBright(Object text) => _style(100, 49).apply(text);

/// bgRedBright style
String bgRedBright(Object text) => _style(101, 49).apply(text);

/// bgGreenBright style
String bgGreenBright(Object text) => _style(102, 49).apply(text);

/// bgYellowBright style
String bgYellowBright(Object text) => _style(103, 49).apply(text);

/// bgBlueBright style
String bgBlueBright(Object text) => _style(104, 49).apply(text);

/// bgMagentaBright style
String bgMagentaBright(Object text) => _style(105, 49).apply(text);

/// bgCyanBright style
String bgCyanBright(Object text) => _style(106, 49).apply(text);

/// bgWhiteBright style
String bgWhiteBright(Object text) => _style(107, 49).apply(text);

_Style _style(int open, int close) {
  return _Style('\u001B[${open}m', '\u001B[${close}m');
}

class _Style {
  const _Style(this.open, this.close);

  final String open;
  final String close;

  String apply(Object obj) {
    String text = obj.toString();
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

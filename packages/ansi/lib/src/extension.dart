import 'style.dart' as style;

extension AnsiString on Object {
  String reset() => style.reset(this);
  String bold() => style.bold(this);
  String dim() => style.dim(this);
  String italic() => style.italic(this);
  String underline() => style.underline(this);
  String inverse() => style.inverse(this);
  String hidden() => style.hidden(this);
  String strikeThrough() => style.strikeThrough(this);

  String black() => style.black(this);
  String red() => style.red(this);
  String green() => style.green(this);
  String yellow() => style.yellow(this);
  String blue() => style.blue(this);
  String magenta() => style.magenta(this);
  String cyan() => style.cyan(this);
  String white() => style.white(this);
  String blackBright() => style.blackBright(this);
  String redBright() => style.redBright(this);
  String greenBright() => style.greenBright(this);
  String yellowBright() => style.yellowBright(this);
  String blueBright() => style.blueBright(this);
  String magentaBright() => style.magentaBright(this);
  String cyanBright() => style.cyanBright(this);
  String whiteBright() => style.whiteBright(this);
  String grey() => style.grey(this);
  String gray() => style.gray(this);

  String bgBlack() => style.bgBlack(this);
  String bgRed() => style.bgRed(this);
  String bgGreen() => style.bgGreen(this);
  String bgYellow() => style.bgYellow(this);
  String bgBlue() => style.bgBlue(this);
  String bgMagenta() => style.bgMagenta(this);
  String bgCyan() => style.bgCyan(this);
  String bgWhite() => style.bgWhite(this);
  String bgBlackBright() => style.bgBlackBright(this);
  String bgRedBright() => style.bgRedBright(this);
  String bgGreenBright() => style.bgGreenBright(this);
  String bgYellowBright() => style.bgYellowBright(this);
  String bgBlueBright() => style.bgBlueBright(this);
  String bgMagentaBright() => style.bgMagentaBright(this);
  String bgCyanBright() => style.bgCyanBright(this);
}

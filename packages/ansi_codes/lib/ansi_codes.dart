const _kColorClose = 39;
const _kBgColorClose = 49;

final _codes = <int, int>{};

class AnsiCode {
  final List<int> codes;
  final int offset;

  AnsiCode(
    int open,
    int close, {
    this.offset = 0,
  }) : codes = List.unmodifiable([open, close]) {
    _codes[open] = close;
  }

  String get open => '\u001B[${codes.first + offset}m';

  String get close => '\u001B[${codes.last + offset}m';
}

class AnsiCodes {
  AnsiCodes();

  /// Modifiers
  final AnsiCode reset = AnsiCode(0, 0);
  final AnsiCode bold = AnsiCode(1, 22);
  final AnsiCode dim = AnsiCode(2, 22);
  final AnsiCode italic = AnsiCode(3, 23);
  final AnsiCode underline = AnsiCode(4, 24);
  final AnsiCode overline = AnsiCode(53, 55);
  final AnsiCode inverse = AnsiCode(7, 27);
  final AnsiCode hidden = AnsiCode(8, 28);
  final AnsiCode strikeThrough = AnsiCode(9, 29);

  /// Colors
  final AnsiCode black = AnsiCode(30, _kColorClose);
  final AnsiCode red = AnsiCode(31, _kColorClose);
  final AnsiCode green = AnsiCode(32, _kColorClose);
  final AnsiCode yellow = AnsiCode(33, _kColorClose);
  final AnsiCode blue = AnsiCode(34, _kColorClose);
  final AnsiCode magenta = AnsiCode(35, _kColorClose);
  final AnsiCode cyan = AnsiCode(36, _kColorClose);
  final AnsiCode white = AnsiCode(37, _kColorClose);

  final AnsiCode blackBright = AnsiCode(90, _kColorClose);
  final AnsiCode redBright = AnsiCode(91, _kColorClose);
  final AnsiCode greenBright = AnsiCode(92, _kColorClose);
  final AnsiCode yellowBright = AnsiCode(93, _kColorClose);
  final AnsiCode blueBright = AnsiCode(94, _kColorClose);
  final AnsiCode magentaBright = AnsiCode(95, _kColorClose);
  final AnsiCode cyanBright = AnsiCode(96, _kColorClose);
  final AnsiCode whiteBright = AnsiCode(97, _kColorClose);

  /// Color Alias
  AnsiCode get gray => blackBright;
  AnsiCode get grey => blackBright;

  /// Background Colors
  final AnsiCode bgBlack = AnsiCode(40, _kBgColorClose);
  final AnsiCode bgRed = AnsiCode(41, _kBgColorClose);
  final AnsiCode bgGreen = AnsiCode(42, _kBgColorClose);
  final AnsiCode bgYellow = AnsiCode(43, _kBgColorClose);
  final AnsiCode bgBlue = AnsiCode(44, _kBgColorClose);
  final AnsiCode bgMagenta = AnsiCode(45, _kBgColorClose);
  final AnsiCode bgCyan = AnsiCode(46, _kBgColorClose);
  final AnsiCode bgWhite = AnsiCode(47, _kBgColorClose);

  final AnsiCode bgBlackBright = AnsiCode(100, _kBgColorClose);
  final AnsiCode bgRedBright = AnsiCode(101, _kBgColorClose);
  final AnsiCode bgGreenBright = AnsiCode(102, _kBgColorClose);
  final AnsiCode bgYellowBright = AnsiCode(103, _kBgColorClose);
  final AnsiCode bgBlueBright = AnsiCode(104, _kBgColorClose);
  final AnsiCode bgMagentaBright = AnsiCode(105, _kBgColorClose);
  final AnsiCode bgCyanBright = AnsiCode(106, _kBgColorClose);
  final AnsiCode bgWhiteBright = AnsiCode(107, _kBgColorClose);

  int? operator [](int? open) => _codes[open];
}

final ansiCodes = AnsiCodes();

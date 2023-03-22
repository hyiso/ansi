import 'src/ansi_wrap.dart';

/// For each newline, wrap separately
String wrapAnsi(
  String string,
  int columns, {
  bool? trim,
  bool? wordWrap,
  bool hard = false,
}) {
  return string
      .replaceAll(RegExp('\r\n'), '\n')
      .split('\n')
      .map((line) =>
          wrap(line, columns, trim: trim, wordWrap: wordWrap, hard: hard))
      .join('\n');
}

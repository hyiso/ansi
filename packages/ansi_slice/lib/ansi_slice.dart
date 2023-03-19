///
/// Slice a [text] with [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Colors_and_Styles)
///
/// [start] and [end] must satisfy 0 <= start <= end <= text.length
String sliceAnsi(String text, {int start = 0, int? end}) {
  end ??= text.length;
  final pattern = RegExp('\x1B\\[[0-9;]*m');
  final buffer = StringBuffer();
  var skip = 0;
  for (var i = 0; i < text.length; i++) {
    final char = text[i];
    if (char == '\x1B') {
      final match = pattern.matchAsPrefix(text.substring(i));
      if (match != null) {
        i += match.end - match.start - 1;
        continue;
      }
    }
    if (skip > 0) {
      skip--;
      continue;
    }
    if (buffer.length >= end) {
      break;
    }
    if (buffer.length >= start) {
      buffer.write(char);
    }
  }
  return buffer.toString();
}

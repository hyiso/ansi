import 'package:ansi_regex/ansi_regex.dart';

/// 
/// Strip [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code) from a [text]
///
/// Use ansiRegex to match ANSI escape codes
String stripAnsi(String text) {
  return text.replaceAll(ansiRegex(), '');
}
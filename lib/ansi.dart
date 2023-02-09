/// Support for doing something awesome.
///
/// More dartdocs go here.
library ansi;

import 'ansi_regex.dart';

String stripAnsi(String source) {
	return source.replaceAll(ansiRegex(), '');
}

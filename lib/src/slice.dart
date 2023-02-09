
import 'dart:math';

import 'package:ansi/src/codes.dart';

import 'utils.dart';

final astralRegex = RegExp(r'^[\uD800-\uDBFF][\uDC00-\uDFFF]$');

final kEscapes = [
	'\u001B',
	'\u009B'
];

String wrapAnsi(dynamic code) => '${kEscapes[0]}[${code}m';

String checkAnsi(List<String> ansiCodes, [bool isEscapes = false, String? endAnsiCode]) {
	var output = <String>[];
  var removes = <String>[];

	for (var ansiCode in ansiCodes) {
		final ansiCodeOrigin = ansiCode;
		if (ansiCode.contains(';')) {
			ansiCode = '${ansiCode.split(';')[0][0]}0';
		}

		final item = codes[int.tryParse(ansiCode, radix: 10)];
		if (item != null) {
			final indexEscape = ansiCodes.indexOf(item.toString());
			if (indexEscape == -1) {
				output.add(wrapAnsi(isEscapes ? item : ansiCodeOrigin));
			} else {
        removes.add(item.toString());
			}
		} else if (isEscapes) {
			output.add(wrapAnsi(0));
			break;
		} else {
			output.add(wrapAnsi(ansiCodeOrigin));
		}
	}
  ansiCodes.removeWhere((element) => removes.contains(element));

	if (isEscapes) {
		output = output.toSet().toList();

		if (endAnsiCode != null) {
			final fistEscapeCode = wrapAnsi(codes[int.tryParse(endAnsiCode, radix: 10)]);
			output = output.fold([], (current, next) => next == fistEscapeCode ? [next, ...current] : [...current, next]);
		}
	}

	return output.join('');
}

/// Slice a string with ANSI escape codes
String sliceAnsi(String input, int begin, [int? end]) {
	final ansiCodes = <String>[];

	int stringEnd = end ?? input.length;
	bool isInsideEscape = false;
	String? ansiCode;
	int visible = 0;
	String output = '';

	for (var i = 0; i < input.length; i++) {
		bool leftEscape = false;
    final character = input[i];

		if (kEscapes.contains(character)) {
			final code = RegExp(r'\d[^m]*').firstMatch(input.substring(i, min(i + 18, input.length)));
			ansiCode = code?.group(0);

			if (visible < stringEnd) {
				isInsideEscape = true;

				if (ansiCode != null) {
					ansiCodes.add(ansiCode);
				}
			}
		} else if (isInsideEscape && character == 'm') {
			isInsideEscape = false;
			leftEscape = true;
		}

		if (!isInsideEscape && !leftEscape) {
			visible++;
		}

		if (!astralRegex.hasMatch(character) && isFullwidthCodePoint(character.codeUnitAt(0))) {
			visible++;

			if (end == null) {
				stringEnd++;
			}
		}

		if (visible > begin && visible <= stringEnd) {
			output += character;
		} else if (visible == begin && !isInsideEscape && ansiCode != null) {
			output = checkAnsi(ansiCodes);
		} else if (visible >= stringEnd) {
			output += checkAnsi(ansiCodes, true, ansiCode);
			break;
		}
	}

	return output;
}
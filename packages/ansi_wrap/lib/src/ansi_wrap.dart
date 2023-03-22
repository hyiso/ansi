import 'package:ansi_codes/ansi_codes.dart';
import 'package:ansi_strip/ansi_strip.dart';
import 'package:characters/characters.dart';
import 'package:string_width/string_width.dart';

final _kEscapes = {
  '\u001B',
  '\u009B',
};
const _kEndCode = 39;
const _kAnsiEscapeBell = '\u0007';
const _kAnsiCsi = '[';
const _kAnsiOsc = ']';
// ignore: constant_identifier_names
const _AnsiSgrTerminator = 'm';
final _kAnsiEscapeLink = '${_kAnsiOsc}8;;';

String wrapAnsiCode(int code) {
  final iterator = _kEscapes.iterator;
  iterator.moveNext();
  String escape = iterator.current;
  return '$escape$_kAnsiCsi$code$_AnsiSgrTerminator';
}

String wrapAnsiHyperlink(String uri) {
  final iterator = _kEscapes.iterator;
  iterator.moveNext();
  String escape = iterator.current;
  return '$escape$_kAnsiEscapeLink$uri$_kAnsiEscapeBell';
}

// Calculate the length of words split on ' ', ignoring
// the extra characters added by ansi escape codes
Iterable<int> wordLengths(String text) =>
    text.split(' ').map((character) => stringWidth(character));

// Wrap a long word across multiple rows
// Ansi escape codes do not count towards length
void wrapWord(List<String> rows, String word, columns) {
  final characters = word.characters;

  bool isInsideEscape = false;
  bool isInsideLinkEscape = false;
  int visible = stringWidth(stripAnsi(rows.last));

  for (var i = 0; i < characters.length; i++) {
    final character = characters.elementAt(i);
    final characterLength = stringWidth(character);

    if (visible + characterLength <= columns) {
      rows.last += character;
    } else {
      rows.add(character);
      visible = 0;
    }

    if (_kEscapes.contains(character)) {
      isInsideEscape = true;
      isInsideLinkEscape =
          characters.getRange(i + 1).join('').startsWith(_kAnsiEscapeLink);
    }

    if (isInsideEscape) {
      if (isInsideLinkEscape) {
        if (character == _kAnsiEscapeBell) {
          isInsideEscape = false;
          isInsideLinkEscape = false;
        }
      } else if (character == _AnsiSgrTerminator) {
        isInsideEscape = false;
      }

      continue;
    }

    visible += characterLength;

    if (visible == columns && i < characters.length - 1) {
      rows.add('');
      visible = 0;
    }
  }

  // It's possible that the last row we copy over is only
  // ansi escape characters, handle this edge-case
  if (visible < 1 && rows.last.isNotEmpty && rows.length > 1) {
    rows[rows.length - 2] += rows.removeLast();
  }
}

// Trims spaces from a string ignoring invisible sequences
String stringVisibleTrimSpacesRight(String string) {
  final words = string.split(' ');
  int last = words.length;

  while (last > 0) {
    if (stringWidth(words[last - 1]) > 0) {
      break;
    }

    last--;
  }

  if (last == words.length) {
    return string;
  }

  return words.sublist(0, last).join(' ') + words.sublist(last).join('');
}

// The wrapAnsi() can be invoked in either 'hard' or 'soft' wrap mode
//
// 'hard' will never allow a string to take up more than columns characters
//
// 'soft' allows long words to expand past the column length
String wrap(
  String string,
  int columns, {
  bool? trim,
  bool? wordWrap,
  bool hard = false,
}) {
  if (trim != false && string.trim().isEmpty) {
    return '';
  }

  String returnValue = '';
  int? escapeCode;
  String? escapeUrl;

  final lengths = wordLengths(string);
  var rows = [''];
  final words = string.split(' ');

  for (var i = 0; i < words.length; i++) {
    if (trim != false) {
      rows.last = rows.last.trimLeft();
    }

    int rowLength = stringWidth(rows.last);

    if (i != 0) {
      if (rowLength >= columns && (wordWrap == false || trim == false)) {
        // If we start with a new word but the current row length equals the length of the columns, add a new row
        rows.add('');
        rowLength = 0;
      }

      if (rowLength > 0 || trim == false) {
        rows.last += ' ';
        rowLength++;
      }
    }

    // In 'hard' wrap mode, the length of a line is never allowed to extend past 'columns'
    final length = lengths.elementAt(i);
    if (hard && length > columns) {
      final remainingColumns = (columns - rowLength);
      final breaksStartingThisLine =
          1 + ((length - remainingColumns - 1) / columns).floor();
      final breaksStartingNextLine = ((length - 1) / columns).floor();
      if (breaksStartingNextLine < breaksStartingThisLine) {
        rows.add('');
      }

      wrapWord(rows, words[i], columns);
      continue;
    }

    if (rowLength + length > columns && rowLength > 0 && length > 0) {
      if (wordWrap == false && rowLength < columns) {
        wrapWord(rows, words[i], columns);
        continue;
      }

      rows.add('');
    }

    if (rowLength + length > columns && wordWrap == false) {
      wrapWord(rows, words[i], columns);
      continue;
    }

    rows.last += words[i];
  }

  if (trim != false) {
    rows = rows.map((row) => stringVisibleTrimSpacesRight(row)).toList();
  }

  final pre = rows.join('\n').characters;

  for (var index = 0; index < pre.length; index++) {
    final character = pre.elementAt(index);
    returnValue += character;

    if (_kEscapes.contains(character)) {
      final groups = RegExp(
              '(?:\\$_kAnsiCsi(?<code>\\d+)m|\\$_kAnsiEscapeLink(?<uri>.*)$_kAnsiEscapeBell)')
          .firstMatch(pre.getRange(index).join(''));
      if (groups?[1] != null) {
        final code = int.tryParse(groups![1]!);
        escapeCode = code == _kEndCode ? null : code;
      } else if (groups?[2] != null) {
        escapeUrl = groups?[2]?.isEmpty == true ? null : groups?[2];
      }
    }

    final code = ansiCodes[escapeCode];
    if (index < pre.length - 1 && pre.elementAt(index + 1) == '\n') {
      if (escapeUrl != null) {
        returnValue += wrapAnsiHyperlink('');
      }

      if (escapeCode != null && code != null) {
        returnValue += wrapAnsiCode(code);
      }
    } else if (character == '\n') {
      if (escapeCode != null && code != null) {
        returnValue += wrapAnsiCode(escapeCode);
      }

      if (escapeUrl != null) {
        returnValue += wrapAnsiHyperlink(escapeUrl);
      }
    }
  }

  return returnValue;
}

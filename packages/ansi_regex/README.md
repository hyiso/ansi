# ansi_regex

> Regular expression for matching [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code)

## Install

```
$ dart pub add ansi_regex
```

## Usage

```dart
import 'package:ansi_regex/ansi_regex.dart';

void main() {
  print(ansiRegex().hasMatch('\u001B[4mcake\u001B[0m'));
  //=> true

  print(ansiRegex().hasMatch('cake'));
  //=> false

  print(ansiRegex().allMatches('\u001B[4mcake\u001B[0m')
    .map((match) => match.group(0)));
  //=> ['\u001B[4m', '\u001B[0m']

  print(ansiRegex().allMatches('\u001B[4mcake\u001B[0m')
    .map((match) => match.group(0)));
  //=> ['\u001B[4m']

  print(ansiRegex().allMatches('\u001B]8;;https://github.com\u0007click\u001B]8;;\u0007')
    .map((match) => match.group(0)));
  //=> ['\u001B]8;;https://github.com\u0007', '\u001B]8;;\u0007']
}

```

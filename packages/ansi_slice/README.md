# ansi_slice

> Slice a string with [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Colors_and_Styles)

## Install

```
$ dart pub add ansi_slice
```

## Usage

```dart
import 'package:ansi/ansi.dart';
import 'package:ansi_slice/ansi_slice.dart';

void main() {
  final string = 'The quick brown ${red('fox jumped over ')}the lazy ${green('dog and then ran away with the unicorn.')}';
  print(sliceAnsi(string, start: 20, end: 30));
}

```

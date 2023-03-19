# ansi_strip

> Strip [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code) from a string

## Install

```bash
$ dart pub add ansi_strip
```

## Usage

```dart
import 'package:ansi_strip/ansi_strip.dart';

void main() {

  print(stripAnsi('\u001B[4mUnicorn\u001B[0m'));
  //=> 'Unicorn'

  print(stripAnsi('\u001B]8;;https://github.com\u0007Click\u001B]8;;\u0007'));
}

```

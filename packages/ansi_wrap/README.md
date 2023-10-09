# ansi_wrap

> Wordwrap a string with [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code#Colors_and_Styles)

## Install

```bash
$ dart pub add ansi_wrap
```

## Usage

```dart
import 'package:ansi/ansi.dart';
import 'package:ansi_wrap/ansi_wrap.dart';

void main() {
  final input = 'The quick brown ${red('fox jumped over ')}the lazy ${green('dog and then ran away with the unicorn.')}';
  print(wrapAnsi(input, 20));
}
```

<img width="331" src="https://github.com/chalk/wrap-ansi/raw/main/screenshot.png">

# ansi

> Terminal string styling done right

![](https://raw.githubusercontent.com/chalk/chalk/main/media/screenshot.png)

<br>

## Install

```bash
dart pub add ansi
```

## Usage

```dart
import 'package:ansi/ansi.dart';

void main() {
  /// Use style method directly
  print(blue('Hello world!'));

  /// Combine styled and normal strings
  print(bgWhite('${blue('Hello')} World${red('!')}'));

  /// Combine styled and normal strings
  print(bgWhite('${blue('Hello')} World${red('!')}'));

  /// Use extension method on String
  print('extension method on String'.cyan());
}

```

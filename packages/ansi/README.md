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
  print(ansi.blue('Hello world!'));

  // Combine styled and normal strings
  print('${ansi.blue('Hello')} World${ansi.red('!')}');
}

```

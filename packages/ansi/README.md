# ansi

> Terminal string styling done right

![](media/screenshot.png)

<br>

---

## Install

```bash
npm install ansi
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

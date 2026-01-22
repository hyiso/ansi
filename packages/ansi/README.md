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

  /// All functions

  underline('Modifier underline');
  strikeThrough('Modifier strikethrough');
  reset('Modifier rest');
  overline('Modifier underline');
  italic('Modifier italic');
  inverse('Modifier inverse');
  hidden('Modifier hidden');
  dim('Modifier dim');
  bold('Modifier bold');

  yellowBright('Color yellowBright');
  yellow('Color yellow');
  whiteBright('Color whiteBright');
  white('Color white');
  redBright('Color redBright');
  red('Color red');
  magentaBright('Color magentaBright');
  magenta('Color magenta');
  greenBright('Color greenBright');
  green('Color green');
  gray('Color gray');
  cyanBright('Color cyanBright');
  cyan('Color cyan');
  blueBright('Color blueBright');
  blue('Color blue');
  blackBright('Color blackBright');
  black('Color black');

  bgYellowBright('Background Color bgYellowBright');
  bgYellow('Background Color bgYellow');
  bgWhiteBright('Background Color bgWhiteBright');
  bgWhite('Background Color bgWhite');
  bgRedBright('Background Color bgRedBright');
  bgRed('Background Color bgRed');
  bgMagentaBright('Background Color bgMagentaBright');
  bgMagenta('Background Color bgMagenta');
  bgGreenBright('Background Color bgGreenBright');
  bgGreen('Background Color bgGreen');
  bgCyanBright('Background Color bgCyanBright');
  bgCyan('Background Color bgCyan');
  bgBlueBright('Background Color bgBlueBright');
  bgBlue('Background Color bgBlue');
  bgBlackBright('Background Color bgBlackBright');
  bgBlack('Background Color bgBlack');
}

```

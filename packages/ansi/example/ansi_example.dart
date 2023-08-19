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

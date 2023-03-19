import 'package:ansi/ansi.dart';

void main() {
  print(ansi.blue('Hello world!'));

  // Combine styled and normal strings
  print(ansi.bgWhite('${ansi.blue('Hello')} World${ansi.red('!')}'));
}

import 'package:ansi_strip/ansi_strip.dart';

void main() {

  print(stripAnsi('\u001B[4mUnicorn\u001B[0m'));
  //=> 'Unicorn'

  print(stripAnsi('\u001B]8;;https://github.com\u0007Click\u001B]8;;\u0007'));
}

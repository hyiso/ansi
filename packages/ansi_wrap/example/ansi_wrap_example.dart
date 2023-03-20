import 'package:ansi/ansi.dart';
import 'package:ansi_wrap/ansi_wrap.dart';

void main() {
  final input = 'The quick brown ${ansi.red('fox jumped over ')}the lazy ${ansi.green('dog and then ran away with the unicorn.')}';
  print(wrapAnsi(input, 20));
}

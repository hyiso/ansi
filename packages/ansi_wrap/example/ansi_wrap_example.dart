import 'package:ansi/ansi.dart';
import 'package:ansi_wrap/ansi_wrap.dart';

void main() {
  final input =
      'The quick brown ${red('fox jumped over ')}the lazy ${green('dog and then ran away with the unicorn.')}';
  print(wrapAnsi(input, 20));
}

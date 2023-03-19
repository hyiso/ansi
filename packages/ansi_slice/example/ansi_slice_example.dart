import 'package:ansi/ansi.dart';
import 'package:ansi_slice/ansi_slice.dart';

void main() {
  final string = 'The quick brown ${ansi.red('fox jumped over ')}the lazy ${ansi.green('dog and then ran away with the unicorn.')}';
  print(sliceAnsi(string, start: 20, end: 30));
}

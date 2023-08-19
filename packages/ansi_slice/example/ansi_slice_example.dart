import 'package:ansi/ansi.dart';
import 'package:ansi_slice/ansi_slice.dart';

void main() {
  final string =
      'The quick brown ${red('fox jumped over ')}the lazy ${green('dog and then ran away with the unicorn.')}';
  print(sliceAnsi(string, start: 20, end: 30));
}

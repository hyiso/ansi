import 'package:ansi_codes/ansi_codes.dart';
import 'package:test/test.dart';

void main() {
  test('return ANSI escape codes', () {
    expect(ansiCodes.green.open, '\u001B[32m');
    expect(ansiCodes.bgGreen.open, '\u001B[42m');
    expect(ansiCodes.green.close, '\u001B[39m');
    expect(ansiCodes.gray.open, ansiCodes.grey.open);
  });

  test('export raw ANSI escape codes', () {
    expect(ansiCodes[0], 0);
    expect(ansiCodes[1], 22);
    expect(ansiCodes[91], 39);
    expect(ansiCodes[40], 49);
    expect(ansiCodes[100], 49);
  });
}

import 'package:test/test.dart';
import 'package:ansi/ansi.dart';

void main() {
  group('Ansi', () {
    test('should reset text', () {
      expect(Ansi.reset(), '\x1B[0m');
    });

    test('should make text bold', () {
      expect(Ansi.bold('text'), '\x1B[1mtext\x1B[0m');
    });

    test('should make text dim', () {
      expect(Ansi.dim('text'), '\x1B[2mtext\x1B[0m');
    });

    test('should make text italic', () {
      expect(Ansi.italic('text'), '\x1B[3mtext\x1B[0m');
    });

    test('should underline text', () {
      expect(Ansi.underline('text'), '\x1B[4mtext\x1B[0m');
    });

    test('should inverse text', () {
      expect(Ansi.inverse('text'), '\x1B[7mtext\x1B[0m');
    });

    test('should color text black', () {
      expect(Ansi.black('text'), '\x1B[30mtext\x1B[0m');
    });

    test('should color text red', () {
      expect(Ansi.red('text'), '\x1B[31mtext\x1B[0m');
    });

    test('should color text green', () {
      expect(Ansi.green('text'), '\x1B[32mtext\x1B[0m');
    });

    test('should color text yellow', () {
      expect(Ansi.yellow('text'), '\x1B[33mtext\x1B[0m');
    });

    test('should color text blue', () {
      expect(Ansi.blue('text'), '\x1B[34mtext\x1B[0m');
    });

    test('should color text magenta', () {
      expect(Ansi.magenta('text'), '\x1B[35mtext\x1B[0m');
    });

    test('should color text cyan', () {
      expect(Ansi.cyan('text'), '\x1B[36mtext\x1B[0m');
    });

    test('should color text white', () {
      expect(Ansi.white('text'), '\x1B[37mtext\x1B[0m');
    });

    test('should color background black', () {
      expect(Ansi.bgBlack('text'), '\x1B[40mtext\x1B[0m');
    });

    test('should color background red', () {
      expect(Ansi.bgRed('text'), '\x1B[41mtext\x1B[0m');
    });

    test('should color background green', () {
      expect(Ansi.bgGreen('text'), '\x1B[42mtext\x1B[0m');
    });

    test('should color background yellow', () {
      expect(Ansi.bgYellow('text'), '\x1B[43mtext\x1B[0m');
    });

    test('should color background blue', () {
      expect(Ansi.bgBlue('text'), '\x1B[44mtext\x1B[0m');
    });

    test('should color background magenta', () {
      expect(Ansi.bgMagenta('text'), '\x1B[45mtext\x1B[0m');
    });

    test('should color background cyan', () {
      expect(Ansi.bgCyan('text'), '\x1B[46mtext\x1B[0m');
    });

    test('should color background white', () {
      expect(Ansi.bgWhite('text'), '\x1B[47mtext\x1B[0m');
    });
  });

  group('sliceAnsi', () {
    test('should return the original string if no ANSI codes are used', () {
      expect(sliceAnsi('Hello world'), equals('Hello world'));
    });

    test('should remove ANSI color codes from a string', () {
      expect(
          sliceAnsi('\u001b[31mHello\u001b[32m \u001b[33mworld\u001b[0m'),
          equals('Hello world'));
    });
    
    test('should remove all ANSI escape sequences from a string', () {
      expect(
          sliceAnsi('\u001b[31mHello\u001b[1;32m \u001b[33mworld\u001b[0m\n'),
          equals('Hello world\n'));
    });
  });

  group('stripAnsi', () {
    test('should strip ANSI escape codes from a string', () {
      final formattedString = '\x1B[31mError:\x1B[0m \x1B[33mSomething went wrong\x1B[0m';
      final expectedString = 'Error: Something went wrong';
      final strippedString = stripAnsi(formattedString);

      expect(strippedString, equals(expectedString));
    });

    test('should return the same string when no ANSI escape codes are present', () {
      final plainString = 'Hello, world!';
      final strippedString = stripAnsi(plainString);

      expect(strippedString, equals(plainString));
    });
  });

}

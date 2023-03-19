import 'package:test/test.dart';
import 'package:ansi/ansi.dart';

void main() {
  test('should reset text', () {
    expect(ansi.reset(), '\x1B[0m');
  });

  test('should make text bold', () {
    expect(ansi.bold('text'), '\x1B[1mtext\x1B[0m');
  });

  test('should make text dim', () {
    expect(ansi.dim('text'), '\x1B[2mtext\x1B[0m');
  });

  test('should make text italic', () {
    expect(ansi.italic('text'), '\x1B[3mtext\x1B[0m');
  });

  test('should underline text', () {
    expect(ansi.underline('text'), '\x1B[4mtext\x1B[0m');
  });

  test('should inverse text', () {
    expect(ansi.inverse('text'), '\x1B[7mtext\x1B[0m');
  });

  test('should color text black', () {
    expect(ansi.black('text'), '\x1B[30mtext\x1B[0m');
  });

  test('should color text red', () {
    expect(ansi.red('text'), '\x1B[31mtext\x1B[0m');
  });

  test('should color text green', () {
    expect(ansi.green('text'), '\x1B[32mtext\x1B[0m');
  });

  test('should color text yellow', () {
    expect(ansi.yellow('text'), '\x1B[33mtext\x1B[0m');
  });

  test('should color text blue', () {
    expect(ansi.blue('text'), '\x1B[34mtext\x1B[0m');
  });

  test('should color text magenta', () {
    expect(ansi.magenta('text'), '\x1B[35mtext\x1B[0m');
  });

  test('should color text cyan', () {
    expect(ansi.cyan('text'), '\x1B[36mtext\x1B[0m');
  });

  test('should color text white', () {
    expect(ansi.white('text'), '\x1B[37mtext\x1B[0m');
  });

  test('should color background black', () {
    expect(ansi.bgBlack('text'), '\x1B[40mtext\x1B[0m');
  });

  test('should color background red', () {
    expect(ansi.bgRed('text'), '\x1B[41mtext\x1B[0m');
  });

  test('should color background green', () {
    expect(ansi.bgGreen('text'), '\x1B[42mtext\x1B[0m');
  });

  test('should color background yellow', () {
    expect(ansi.bgYellow('text'), '\x1B[43mtext\x1B[0m');
  });

  test('should color background blue', () {
    expect(ansi.bgBlue('text'), '\x1B[44mtext\x1B[0m');
  });

  test('should color background magenta', () {
    expect(ansi.bgMagenta('text'), '\x1B[45mtext\x1B[0m');
  });

  test('should color background cyan', () {
    expect(ansi.bgCyan('text'), '\x1B[46mtext\x1B[0m');
  });

  test('should color background white', () {
    expect(ansi.bgWhite('text'), '\x1B[47mtext\x1B[0m');
  });

}

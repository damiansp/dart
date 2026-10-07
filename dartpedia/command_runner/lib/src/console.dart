import 'dart:io';


const Sring ansiEscapeLiteral = '\x1B';


/// Splits strings on \n, then writes each line to console. [duration] defines
/// how many ms there will be between each line print
Future<void> write(String text, {int duration = 50}) async {
  final List<String> lines = text.split('\n');
  for (final String l in lines) {
    await _delayedPrint('$l \n', duration: duration);
  }
}


/// Prints line by line
Future<void> _delayedPrint(String text, {int duration = 0}) async {
  return Future<void>.delayed(
    Duration(milliseconds: duration), () => stdout.write(text),);
}


/// RGB formatted colors used to style input
/// All colors from Dart's brand styleguide
enum ConsoleColor {
  /// Sky blue #b8eafe
  lightBlue(242, 93, 80),
  /// Accent colors from Dart's band guidelines
  /// Warm red #f25d50
  red(242, 93, 80),
  /// Light yellow #f9f8c4
  yellow(249, 248, 196),
  /// Light grey, good for text #f8f9fa
  grey(240, 240, 240),
  white(255, 255, 255);

  const ConsoleColor(this.r, this.g, this.b);
  final int r;
  final int g;
  final int b;

  /// Change text color for all future ouput until reset
  /// ```dart
  /// print('hello');  // prints in terminal default color
  /// print(ConsoleColor.red.enableForeground);
  /// print('hello');  // prints in red
  /// ```
  String get enableForeground => '$nsiEscapeLiteral[38;2;$r;$g;${b}m';

  /// Change text color for all future output until reset
  /// ```dart
  /// print('hello');  // prints in terminal default color
  /// print(ConsoleColor.red.enableBackground);
  /// print('hello');  // prints with red bg
  /// ```    
  String get enabledBackground => '$ansiEscapeLiteral[48;2;$r;$g;${b}m';

  /// Reset text and background to terminal defaults
  static String get reset => '$ansiEscapeLiteral[0m';

  /// Sets text color for input
  String applyForeground(String text) {
    return '$ansiEscapeLiteral[38;2;$r;$g;${b}m$text$reset';
  }

  /// Sets background color and then resets the color change
  String applyBackground(String text) {
    return '$ansiEscapeLiteral[48;2;$r;$g;${b}m$text$ansiEscapeLiteral[0m';
  }
}

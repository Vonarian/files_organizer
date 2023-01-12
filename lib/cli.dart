import 'dart:io';

import 'package:ansicolor/ansicolor.dart';
import 'package:args/args.dart';

final errorPen = AnsiPen()..red();
final helpPen = AnsiPen()..blue();
final infoPen = AnsiPen()..cyan();
final successPen = AnsiPen()..green();
final warningPen = AnsiPen()..yellow();

class CliHandler {
  static ArgResults getResults(
      List<String> args, List<Command> commands, List<Flag> flags) {
    final parser = ArgParser();
    for (var command in commands) {
      parser.addOption(
        command.name,
        abbr: command.abbr,
      );
    }
    for (var flag in flags) {
      parser.addFlag(flag.name,
          negatable: false, abbr: flag.abbr, defaultsTo: false);
    }
    final results = parser.parse(args);
    return results;
  }
}

class InputHandler {
  static String? getInput() {
    String? input = stdin.readLineSync();
    return input;
  }

  static Future<String?> validateInput(String? input) async {
    bool isDir = input != null ? await Directory(input).exists() : false;
    if (isDir) {
      return input;
    }
    while (!isDir) {
      stdout.write(warningPen(
          'Incorrect input!\nEnter the directory you want to organize: '));
      input = getInput();
      isDir = input != null ? await Directory(input).exists() : false;
    }
    if (isDir) return input;
    return null;
  }

  static Future<String?> getValidateInput() async {
    String? input = getInput();
    input = await validateInput(input);
    stdout.writeln(errorPen('Received input is null/not a directory.'));
    return input;
  }
}

class Command {
  final String name;
  final String? abbr;

  const Command({required this.name, this.abbr});
}

class Flag {
  final String name;
  final String? abbr;

  const Flag({required this.name, this.abbr});
}

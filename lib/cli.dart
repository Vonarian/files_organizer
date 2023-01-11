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

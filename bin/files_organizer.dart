import 'dart:io';

import 'package:files_organizer/cli.dart';
import 'package:files_organizer/data.dart';
import 'package:files_organizer/organizer.dart';
import 'package:path/path.dart' as p;

import 'constants.dart';
import 'info.dart';

Future<void> main(List<String> args) async {
  final sw = Stopwatch()
    ..start();
  String? tempInput;

  if (args.isEmpty) {
    stdout.writeln(errorPen('No arguments are passed to the application.'));
    stdout.write(warningPen(
        'Enter the directory path you want to organize, use -h flag to check help: '));
    tempInput = await InputHandler.getValidateInput();
  }

  final List<String> knownFiles = Extensions.extensions;
  String knownExtensions = '';
  for (int i = 0; i < knownFiles.length; i++) {
    final extension = knownFiles[i];
    if (i != knownFiles.length - 1) {
      knownExtensions += '$extension, ';
    } else {
      knownExtensions += extension;
    }
  }

  try {
    final results = CliHandler.getResults(args, commands, flags);

    if (results['help']) {
      stdout.writeln(helpPen(Info.help));
      stdout.writeln(infoPen(Info.runMessage(knownExtensions)));
      stdout.writeln(infoPen(Info.developer));
      stdout.writeln(successPen('Executed in ${sw.elapsedMilliseconds} ms!'));
      exit(0);
    }

    String directory = tempInput ?? results['directory'];
    if (directory.isEmpty) {
      final inputDir = await InputHandler.getValidateInput();
      if (inputDir != null) {
        directory = inputDir;
      } else {
        stdout
            .writeln(errorPen('Your input ($inputDir) is incorrect\nExiting!'));
        exit(1);
      }
    }
    if (directory.endsWith('\\') || directory.endsWith('/')) {
      directory = directory.substring(0, directory.length - 1);
    }
    final organizer = await Organizer.initialize(directory);
    await organizer.organize();
  } catch (e, st) {
    stdout.writeln(warningPen('Error occurred during organization of files:'));
    stdout.writeln(errorPen(e));
    final errorFile =
    File('${p.dirname(Platform.resolvedExecutable)}\\log.txt');
    await errorFile
        .writeAsString('Error occurred during organization of files:\n$e\n$st');
    stdout.writeln(
        infoPen('Error and stacktrace have been written to ${errorFile.path}'));
    exit(1);
  }

  stdout.writeln(successPen('Executed in ${sw.elapsedMilliseconds} ms!'));
  sw.stop();
}

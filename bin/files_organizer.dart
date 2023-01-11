import 'dart:io';

import 'package:files_organizer/cli.dart';
import 'package:files_organizer/data.dart';
import 'package:files_organizer/organizer.dart';
import 'package:path/path.dart' as p;

import 'constants.dart';

Future<void> main(List<String> args) async {
  final sw = Stopwatch()..start();
  if (args.isEmpty) {
    stdout.write(
        errorPen('No arguments are passed to the application.\nExiting!'));
    exit(160);
  }
  final List<String> knownFiles = [
    ...Extensions.images,
    ...Extensions.compressed,
    ...Extensions.documents,
    ...Extensions.installers,
    ...Extensions.musics,
    ...Extensions.programs,
    ...Extensions.videos
  ];
  String knownExtensions = '';
  for (var extension in knownFiles) {
    knownExtensions += '$extension, ';
  }
  stdout.write(infoPen(Info.runMessage(knownExtensions)));
  final results = CliHandler.getResults(args, commands, flags);
  if (results['help']) {
    stdout.write(helpPen(Info.help));
    stdout.write(infoPen(Info.developer));
    exit(0);
  }
  String directory = results['directory'];
  if (!directory.lastIndexOf(RegExp('\\|/')).isNegative) {
    directory = directory.substring(0, directory.length - 1);
  }
  try {
    final organizer = await Organizer.initialize(directory);
    await organizer.organize();
  } catch (e, st) {
    stdout.write(warningPen('Error occurred during organization of files:\n'));
    stdout.write(errorPen(e));
    final errorFile =
        File('${p.dirname(Platform.resolvedExecutable)}\\log.txt');
    await errorFile
        .writeAsString('Error occurred during organization of files:\n$e\n$st');
    stdout.write(infoPen(
        '\nError and stacktrace have been written to ${errorFile.path}'));
  }
  stdout.write(successPen('\nExecuted in ${sw.elapsedMilliseconds} ms!'));
  sw.stop();
}

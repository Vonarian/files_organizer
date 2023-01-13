import 'dart:io';

import 'package:files_organizer/data.dart';
import 'package:path/path.dart' as p;

import 'cli.dart';

class Organizer {
  final String directory;

  const Organizer(this.directory);

  static Future<Organizer> initialize(String directory) async {
    final dir = Directory(directory);
    final bool isDirectory = await dir.exists();
    if (!isDirectory) {
      stdout.writeln(errorPen(
          '$directory is not a directory or is not accessible.\nExiting!'));
      exit(1);
    }

    final filesList = (await dir.list().toList()).whereType<File>();
    if (filesList.isEmpty) {
      throw Exception(errorPen('No files found in the directory.'));
    }

    return Organizer(directory);
  }

  Future<void> organize() async {
    final dir = Directory(directory);

    final filesList = (await dir.list().toList()).whereType<File>().toList()
      ..removeWhere((element) =>
      p.basename(element.path) == p.basename(Platform.resolvedExecutable));

    final foldersList = List<Directory>.generate(Folders.folders.length,
            (index) => Directory('$directory\\${Folders.folders[index]}'));

    for (final dir in foldersList) {
      if (!dir.existsSync()) {
        dir.create(recursive: true);
      }
    }

    for (var file in filesList) {
      final lowerPath = file.path.toLowerCase();
      final name = p.basename(file.path);
      final extension = p.extension(lowerPath).replaceAll('.', '');
      final bool isGeneral = !Extensions.extensions.contains(extension);

      if (Extensions.programs.contains(extension)) {
        final copyPath = '$directory\\${Folders.programs}\\$name';
        file.copySync(copyPath);
        if (await File(copyPath).exists()) {
          file.delete();
        }
      }
      if (Extensions.compressed.contains(extension)) {
        final copyPath = '$directory\\${Folders.compressed}\\$name';
        file.copySync(copyPath);
        if (await File(copyPath).exists()) {
          file.deleteSync();
        }
      }
      if (Extensions.images.contains(extension)) {
        final copyPath = '$directory\\${Folders.images}\\$name';
        file.copySync(copyPath);
        if (await File(copyPath).exists()) {
          file.deleteSync();
        }
      }
      if (Extensions.documents.contains(extension)) {
        final copyPath = '$directory\\${Folders.documents}\\$name';
        file.copySync(copyPath);
        if (await File(copyPath).exists()) {
          file.deleteSync();
        }
      }
      if (Extensions.installers.contains(extension)) {
        final copyPath = '$directory\\${Folders.installers}\\$name';
        file.copySync(copyPath);
        if (await File(copyPath).exists()) {
          file.deleteSync();
        }
      }
      if (Extensions.musics.contains(extension)) {
        final copyPath = '$directory\\${Folders.musics}\\$name';
        file.copySync(copyPath);
        if (await File(copyPath).exists()) {
          file.deleteSync();
        }
      }
      if (Extensions.videos.contains(extension)) {
        final copyPath = '$directory\\${Folders.videos}\\$name';
        file.copySync(copyPath);
        if (await File(copyPath).exists()) {
          file.deleteSync();
        }
      }
      if (isGeneral) {
        final copyPath = '$directory\\${Folders.general}\\$name';
        file.copySync(copyPath);
        if (await File(copyPath).exists()) {
          file.deleteSync();
        }
      }
    }

    for (final folder in foldersList) {
      final folderContent = folder.list();
      if (await folderContent.isEmpty) {
        stdout.writeln(infoPen(
            'Folder "${p.basename(folder.path)}" is empty, deleting...'));
        folder.deleteSync();
      }
    }

    stdout
        .writeln(successPen('${filesList.length} files have been organized!'));
  }
}

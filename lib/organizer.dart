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
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
    }
    for (var file in filesList) {
      final lowerPath = file.path.toLowerCase();
      final name = p.basename(file.path);
      final extension = p.extension(lowerPath).replaceAll('.', '');
      final bool isGeneral = !Extensions.extensions.contains(extension);
      if (Extensions.programs.contains(extension)) {
        final copyPath = '$directory\\${Folders.programs}\\$name';
        await file.copy(copyPath);
        if (await File(copyPath).exists()) {
          await file.delete();
        }
      }
      if (Extensions.compressed.contains(extension)) {
        final copyPath = '$directory\\${Folders.compressed}\\$name';
        await file.copy(copyPath);
        if (await File(copyPath).exists()) {
          await file.delete();
        }
      }
      if (Extensions.images.contains(extension)) {
        final copyPath = '$directory\\${Folders.images}\\$name';
        await file.copy(copyPath);
        if (await File(copyPath).exists()) {
          await file.delete();
        }
      }
      if (Extensions.documents.contains(extension)) {
        final copyPath = '$directory\\${Folders.documents}\\$name';
        await file.copy(copyPath);
        if (await File(copyPath).exists()) {
          await file.delete();
        }
      }
      if (Extensions.installers.contains(extension)) {
        final copyPath = '$directory\\${Folders.installers}\\$name';
        await file.copy(copyPath);
        if (await File(copyPath).exists()) {
          await file.delete();
        }
      }
      if (Extensions.musics.contains(extension)) {
        final copyPath = '$directory\\${Folders.musics}\\$name';
        await file.copy(copyPath);
        if (await File(copyPath).exists()) {
          await file.delete();
        }
      }
      if (Extensions.videos.contains(extension)) {
        final copyPath = '$directory\\${Folders.videos}\\$name';
        await file.copy(copyPath);
        if (await File(copyPath).exists()) {
          await file.delete();
        }
      }
      if (isGeneral) {
        final copyPath = '$directory\\${Folders.general}\\$name';
        await file.copy(copyPath);
        if (await File(copyPath).exists()) {
          await file.delete();
        }
      }
    }
    for (final folder in foldersList) {
      final folderContent = await folder.list().toList();
      if (folderContent.isEmpty) {
        stdout.writeln(infoPen(
            'Folder "${p.basename(folder.path)}" is empty, deleting...'));
        await folder.delete();
      }
    }
    stdout
        .writeln(successPen('${filesList.length} files have been organized!'));
  }
}

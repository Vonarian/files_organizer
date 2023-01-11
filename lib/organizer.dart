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
      stdout.write(errorPen(
          '$directory is not a directory or is not accessible.\nExiting!'));
      exit(1);
    }
    final filesList = (await dir.list().toList()).whereType<File>();
    if (filesList.isEmpty) {
      throw Exception(errorPen('No files found in the directory.'));
    }
    final generalDir = Directory('$directory\\${Folders.general}');
    final videosDir = Directory('$directory\\${Folders.videos}');
    final musicsDir = Directory('$directory\\${Folders.musics}');
    final installersDir = Directory('$directory\\${Folders.installers}');
    final documentsDir = Directory('$directory\\${Folders.documents}');
    final compressedDir = Directory('$directory\\${Folders.compressed}');
    final programsDir = Directory('$directory\\${Folders.programs}');
    final imagesDir = Directory('$directory\\${Folders.images}');
    if (!await generalDir.exists()) {
      await generalDir.create(recursive: true);
    }
    if (!await videosDir.exists()) {
      await videosDir.create(recursive: true);
    }
    if (!await musicsDir.exists()) {
      await musicsDir.create(recursive: true);
    }
    if (!await installersDir.exists()) {
      await installersDir.create(recursive: true);
    }
    if (!await documentsDir.exists()) {
      await documentsDir.create(recursive: true);
    }
    if (!await compressedDir.exists()) {
      await compressedDir.create(recursive: true);
    }
    if (!await programsDir.exists()) {
      await programsDir.create(recursive: true);
    }
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }
    return Organizer(directory);
  }

  Future<void> organize() async {
    final dir = Directory(directory);
    final filesList = (await dir.list().toList()).whereType<File>();
    for (var file in filesList) {
      final lowerPath = file.path.toLowerCase();
      final name = p.basename(file.path);
      final extension = p.extension(lowerPath).replaceAll('.', '');
      final bool isGeneral = !Extensions.programs.contains(extension) &&
          !Extensions.documents.contains(extension) &&
          !Extensions.installers.contains(extension) &&
          !Extensions.musics.contains(extension) &&
          !Extensions.videos.contains(extension) &&
          !Extensions.compressed.contains(extension) &&
          !Extensions.images.contains(extension);
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
        {
          final copyPath = '$directory\\${Folders.general}\\$name';
          await file.copy(copyPath);
          if (await File(copyPath).exists()) {
            await file.delete();
          }
        }
      }
    }
    stdout.write(successPen('${filesList.length} files have been organized!'));
  }
}

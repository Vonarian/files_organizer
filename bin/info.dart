class Info {
  static const help = '''
Files Organizer CLI app written in Dart to organize files in the passed directory.
Pass directory using -d <directory path here>. Example:
.\\files_organizer.exe -d C:\\Users\\Vonarian\\Downloads

If the directory contains spaces, make sure you put " before and after passed directory path. Example:
.\\files_organizer.exe -d "C:\\Folder With Space"
''';
  static const developer =
      'Developed by Vonarian (https://github.com/Vonarian)';

  static String runMessage(String knownExtensions) {
    return '''
Command-Line app to organize files into different types:
Images, Programs, Installers, Videos, Musics, Archives and Documents
Other files which are not known by the program will be put inside the "General" folder
Known Extensions = $knownExtensions.
''';
  }
}

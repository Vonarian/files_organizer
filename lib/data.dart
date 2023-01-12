class Extensions {
  static const programs = [
    'exe',
    'bat',
    'js',
    'py',
    'ahk',
    'jar',
  ];
  static const installers = [
    'msi',
    'msix',
    'appxbundle',
    'apk',
    'appbundle',
    'app',
    'appimage',
    'ipa',
  ];
  static const compressed = [
    'zip',
    'rar',
    'arj',
    'gz',
    'sit',
    'sitx',
    'sea',
    'ace',
    'bz2',
    '7z',
  ];
  static const documents = [
    'doc',
    'pdf',
    'ppt',
    'pps',
    'docx',
    'pptx',
  ];
  static const musics = [
    'mp3',
    'wav',
    'wma',
    'mpa',
    'ram',
    'ra',
    'aac',
    'aif',
    'm4a',
    'tsa',
  ];
  static const videos = [
    'avi',
    'mpg',
    'mpe',
    'mpeg',
    'asf',
    'wmv',
    'mov',
    'qt',
    'rm',
    'mp4',
    'flv',
    'm4v',
    'webm',
    'ogv',
    'ogg',
    'mkv',
    'ts',
    'tsv'
  ];
  static const images = [
    'jpeg',
    'jpg',
    'gif',
    'tiff',
    'raw',
    'png',
  ];

  static List<String> get extensions => [
        ...images,
        ...compressed,
        ...documents,
        ...installers,
        ...musics,
        ...programs,
        ...videos,
      ];
}

class Folders {
  static const programs = 'Programs';
  static const installers = 'Installers';
  static const compressed = 'Compressed';
  static const musics = 'Music';
  static const videos = 'Video';
  static const documents = 'Documents';
  static const general = 'General';
  static const images = 'Images';

  static List<String> get folders => [
        programs,
        installers,
        compressed,
        musics,
        videos,
        documents,
        general,
        images
      ];
}

abstract class FileModelBase {}

class FileModelError extends FileModelBase {
  final String message;

  FileModelError({
    required this.message,
  });
}

class FileModel extends FileModelBase {
  final int fileId;
  final String filePath;
  final String fileName;
  final bool userAt;
  final DateTime createDt;
  final DateTime updateDt;

  FileModel({
    required this.fileId,
    required this.filePath,
    required this.fileName,
    required this.userAt,
    required this.createDt,
    required this.updateDt,
  });
}

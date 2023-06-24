import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class FileManager {
  const FileManager();

  Future<File> copyToAppDir(File file) => getApplicationDocumentsDirectory()
      .then((d) => join(d.path, basename(file.path)))
      .then(file.copy);

  Future<File> loadFromAppDir(String path) => getApplicationDocumentsDirectory()
      .then((d) => join(d.path, path))
      .then(File.new);
}

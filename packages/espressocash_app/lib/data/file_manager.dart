import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

abstract final class FileManager {
  const FileManager();

  static Future<File> copyToAppDir(File file) => getApplicationDocumentsDirectory()
      .then((d) => join(d.path, basename(file.path)))
      .then(file.copy);

  static Future<File> loadFromAppDir(String path) =>
      getApplicationDocumentsDirectory().then((d) => join(d.path, path)).then(File.new);
}

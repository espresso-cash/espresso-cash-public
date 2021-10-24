String formatDocumentation(
  String documentation, {
  int indent = 1,
}) {
  final oldLines = documentation.split('\n');
  final newLines = <String>[];

  for (var line in oldLines) {
    while (line.length > 60) {
      final content = line.substring(0, 60);
      final lastSpaceIndex = content.lastIndexOf(' ');
      final optimalLine = content.substring(0, lastSpaceIndex).trim();

      newLines.add(optimalLine);
      line = line.substring(optimalLine.length + 1);
    }
    newLines.add(line.trim());
  }

  return '    /// ${newLines.join('\n    /// ')}';
}

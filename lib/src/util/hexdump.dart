import 'dart:io';

void hexdump(List<int> bytes, [int width = 32]) {
  for (int i = 0; i < bytes.length; i++) {
    stdout.write('${bytes[i].toRadixString(16).padLeft(2, "0")} ');
    if ((i + 1) % width == 0) {
      stdout.write('\n');
    }
  }
}

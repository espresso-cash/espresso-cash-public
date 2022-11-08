import 'package:borsh_annotation/borsh_annotation.dart';

class BFixedString extends BType<String> {
  const BFixedString(this.length);

  final int length;

  @override
  String read(BinaryReader reader) {
    final realLength = reader.readU32();
    if (length != realLength) {
      throw FormatException(
        'Invalid length: expected $length, got $realLength',
      );
    }

    final array = reader.readFixedArray(length, reader.readU8);
    final zeroIndex = array.indexOf(0);
    final result = zeroIndex == -1 ? array : array.sublist(0, zeroIndex);

    return String.fromCharCodes(result);
  }

  @override
  void write(BinaryWriter writer, String value) {
    final array = value.codeUnits;
    if (array.length > length) {
      throw Exception('String is too long');
    }

    writer
      ..writeU32(length)
      ..writeFixedArray(array, writer.writeU8)
      ..writeFixedArray(List.filled(length - array.length, 0), writer.writeU8);
  }
}

import 'package:borsh_annotation/borsh_annotation.dart';

class BMetaString extends BType<String> {
  const BMetaString();

  @override
  void write(BinaryWriter writer, String value) {
    writer.writeString(value);
  }

  @override
  String read(BinaryReader reader) =>
      reader.readString().replaceFirst(RegExp('\x00+\$'), '');
}

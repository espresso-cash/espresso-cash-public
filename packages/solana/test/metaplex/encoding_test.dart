import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/src/metaplex/borsh_ext.dart';
import 'package:test/test.dart';

void main() {
  group('BMetaString', () {
    const BMetaString bMetaString = BMetaString();
    const String testString = 'test';
    const String testStringWithNull = 'test\x00\x00\x00';

    test('should write the given string to the writer', () {
      final writer = BinaryWriter();
      bMetaString.write(writer, testString);

      expect(writer.toArray(), equals([4, 0, 0, 0, 116, 101, 115, 116]));
    });

    test(
        'should read a string from the reader and remove trailing null characters',
        () {
      final writer = BinaryWriter();
      bMetaString.write(writer, testStringWithNull);

      final reader = BinaryReader(
        Uint8List.fromList(writer.toArray()).buffer.asByteData(),
      );
      final result = bMetaString.read(reader);

      expect(result, equals(testString));
    });
  });
}

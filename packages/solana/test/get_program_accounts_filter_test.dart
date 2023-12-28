import 'package:solana/dto.dart';
import 'package:test/test.dart';

void main() {
  group('Test program account filter serialization', () {
    test('can serialize a simple filter', () {
      expect(
        ProgramDataFilter.memcmp(offset: 1, bytes: '123'.codeUnits).toJson(),
        equals(<String, dynamic>{
          'memcmp': {
            'offset': 1,
            'bytes': 'HXRC',
          },
        }),
      );

      expect(
        ProgramDataFilter.memcmp(
          offset: 0,
          bytes: 'some different data'.codeUnits,
        ).toJson(),
        equals(<String, dynamic>{
          'memcmp': {
            'offset': 0,
            'bytes': 'N8huH18outpM8wBvyyeH9z6tiL',
          },
        }),
      );
    });

    test('can serialize a filter built with base58 factory', () {
      expect(
        ProgramDataFilter.memcmpBase58(
          offset: 1,
          bytes: 'N8huH18outpM8wBvyyeH9z6tiL',
        ).toJson(),
        equals(<String, dynamic>{
          'memcmp': {
            'offset': 1,
            'bytes': 'N8huH18outpM8wBvyyeH9z6tiL',
          },
        }),
      );
    });
  });
}

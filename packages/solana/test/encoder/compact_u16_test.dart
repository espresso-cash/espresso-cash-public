import 'package:solana/src/encoder/compact_u16.dart';
import 'package:test/test.dart';

void main() {
  const values = <int, Iterable<int>>{
    10: [10],
    1000: [232, 7],
    10000: [144, 78],
  };

  for (final value in values.entries) {
    test('CompactU16 for ${value.key}', () {
      final compact = CompactU16(value.key);
      final fromRaw = CompactU16.raw(compact.toByteArray().toList());
      expect(compact.toByteArray(), value.value);
      expect(fromRaw.value, value.key);
    });
  }
}

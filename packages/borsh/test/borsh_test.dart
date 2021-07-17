import 'package:test/test.dart';

import 'borsh_test_structs/simple_struct1.dart';

void main() {
  test('Borsh', () {
    const original = SimpleStruct1(
      strValue: 'Example',
      int32Value: 13,
      fixedIntegersArray: [1, 2, 3],
      dynamicStringArray: ['string 1', 'one more', 'and last one'],
    );
    final bytes = original.toBorsh();
    final deserialized = SimpleStruct1.fromBorsh(bytes);

    expect(bytes.length, equals(62));
    expect(original.strValue, equals(deserialized.strValue));
    expect(original.int32Value, equals(deserialized.int32Value));
  });
}

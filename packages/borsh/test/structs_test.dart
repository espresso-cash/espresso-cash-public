import 'package:test/test.dart';

import 'structs.dart';

void main() {
  test('serializes and deserializes test structure', () {
    final struct = Test1(
      stringValue: 'test',
      intValue: 1,
      bigIntValue: BigInt.one,
      listOfStrings: ['a', 'b', 'c'],
      listOfInts: [1, 2, 3],
      listOfListsOfInts: [
        [1, 2],
        [3, 4],
        [5, 6],
      ],
      dynamicListOfStrings: ['a', 'b', 'c'],
    );

    final serialized = struct.toBorsh();
    final deserialized = Test1.fromBorsh(serialized);

    expect(deserialized.stringValue, struct.stringValue);
    expect(deserialized.intValue, struct.intValue);
    expect(deserialized.listOfStrings, struct.listOfStrings);
    expect(deserialized.listOfInts, struct.listOfInts);
    expect(deserialized.listOfListsOfInts, struct.listOfListsOfInts);
  });

  test('serializes and deserializes composite structure', () {
    final struct = CompositeStruct(
      intValue: 10,
      simpleStruct: SimpleStruct(stringValue: 'test', intValue: 22),
    );

    final serialized = struct.toBorsh();
    final deserialized = CompositeStruct.fromBorsh(serialized);

    expect(deserialized.intValue, struct.intValue);
    expect(
      deserialized.simpleStruct.stringValue,
      struct.simpleStruct.stringValue,
    );
    expect(deserialized.simpleStruct.intValue, struct.simpleStruct.intValue);
  });

  group('option:', () {
    test('with none', () {
      final struct = StructWithOption(stringValue: 'a', option: null);

      final serialized = struct.toBorsh();
      final deserialized = StructWithOption.fromBorsh(serialized);

      expect(deserialized.stringValue, struct.stringValue);
      expect(deserialized.option, struct.option);
    });

    test('with some', () {
      final struct = StructWithOption(stringValue: 'a', option: 'b');

      final serialized = struct.toBorsh();
      final deserialized = StructWithOption.fromBorsh(serialized);

      expect(deserialized.stringValue, struct.stringValue);
      expect(deserialized.option, struct.option);
    });
  });
}

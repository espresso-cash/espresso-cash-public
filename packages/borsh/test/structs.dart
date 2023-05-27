import 'package:borsh_annotation/borsh_annotation.dart';

part 'structs.g.dart';

@BorshSerializable()
class Test1 with _$Test1 {
  factory Test1({
    @BString() required String stringValue,
    @BU8() required int intValue,
    @BU64() required BigInt bigIntValue,
    @BFixedArray(3, BString()) required List<String> listOfStrings,
    @BFixedArray(3, BU8()) required List<int> listOfInts,
    @BFixedArray(3, BFixedArray(2, BU8()))
    required List<List<int>> listOfListsOfInts,
    @BArray(BString()) required List<String> dynamicListOfStrings,
  }) = _Test1;

  const Test1._();

  factory Test1.fromBorsh(Uint8List data) => _$Test1FromBorsh(data);
}

@BorshSerializable()
class SimpleStruct with _$SimpleStruct {
  factory SimpleStruct({
    @BString() required String stringValue,
    @BU8() required int intValue,
  }) = _SimpleStruct;

  const SimpleStruct._();

  factory SimpleStruct.fromBorsh(Uint8List data) =>
      _$SimpleStructFromBorsh(data);
}

@BorshSerializable()
class CompositeStruct with _$CompositeStruct {
  factory CompositeStruct({
    @BU8() required int intValue,
    @BSimpleStruct() required SimpleStruct simpleStruct,
  }) = _CompositeStruct;

  const CompositeStruct._();

  factory CompositeStruct.fromBorsh(Uint8List data) =>
      _$CompositeStructFromBorsh(data);
}

@BorshSerializable()
class StructWithOption with _$StructWithOption {
  factory StructWithOption({
    @BString() required String stringValue,
    @BOption(BString()) required String? option,
  }) = _StructWithOption;

  const StructWithOption._();

  factory StructWithOption.fromBorsh(Uint8List data) =>
      _$StructWithOptionFromBorsh(data);
}

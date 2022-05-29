// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'structs.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$Test1 {
  String get stringValue => throw UnimplementedError();
  int get intValue => throw UnimplementedError();
  BigInt get bigIntValue => throw UnimplementedError();
  List<String> get listOfStrings => throw UnimplementedError();
  List<int> get listOfInts => throw UnimplementedError();
  List<List<int>> get listOfListsOfInts => throw UnimplementedError();
  List<String> get dynamicListOfStrings => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BString().write(writer, stringValue);
    const BU8().write(writer, intValue);
    const BU64().write(writer, bigIntValue);
    const BFixedArray(3, BString()).write(writer, listOfStrings);
    const BFixedArray(3, BU8()).write(writer, listOfInts);
    const BFixedArray(3, BFixedArray(2, BU8()))
        .write(writer, listOfListsOfInts);
    const BArray(BString()).write(writer, dynamicListOfStrings);

    return writer.toArray();
  }
}

class _Test1 extends Test1 {
  _Test1({
    required this.stringValue,
    required this.intValue,
    required this.bigIntValue,
    required this.listOfStrings,
    required this.listOfInts,
    required this.listOfListsOfInts,
    required this.dynamicListOfStrings,
  }) : super._();

  final String stringValue;
  final int intValue;
  final BigInt bigIntValue;
  final List<String> listOfStrings;
  final List<int> listOfInts;
  final List<List<int>> listOfListsOfInts;
  final List<String> dynamicListOfStrings;
}

class BTest1 implements BType<Test1> {
  const BTest1();

  @override
  void write(BinaryWriter writer, Test1 value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  Test1 read(BinaryReader reader) {
    return Test1(
      stringValue: const BString().read(reader),
      intValue: const BU8().read(reader),
      bigIntValue: const BU64().read(reader),
      listOfStrings: const BFixedArray(3, BString()).read(reader),
      listOfInts: const BFixedArray(3, BU8()).read(reader),
      listOfListsOfInts:
          const BFixedArray(3, BFixedArray(2, BU8())).read(reader),
      dynamicListOfStrings: const BArray(BString()).read(reader),
    );
  }
}

Test1 _$Test1FromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BTest1().read(reader);
}

mixin _$SimpleStruct {
  String get stringValue => throw UnimplementedError();
  int get intValue => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BString().write(writer, stringValue);
    const BU8().write(writer, intValue);

    return writer.toArray();
  }
}

class _SimpleStruct extends SimpleStruct {
  _SimpleStruct({
    required this.stringValue,
    required this.intValue,
  }) : super._();

  final String stringValue;
  final int intValue;
}

class BSimpleStruct implements BType<SimpleStruct> {
  const BSimpleStruct();

  @override
  void write(BinaryWriter writer, SimpleStruct value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  SimpleStruct read(BinaryReader reader) {
    return SimpleStruct(
      stringValue: const BString().read(reader),
      intValue: const BU8().read(reader),
    );
  }
}

SimpleStruct _$SimpleStructFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BSimpleStruct().read(reader);
}

mixin _$CompositeStruct {
  int get intValue => throw UnimplementedError();
  SimpleStruct get simpleStruct => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, intValue);
    const BSimpleStruct().write(writer, simpleStruct);

    return writer.toArray();
  }
}

class _CompositeStruct extends CompositeStruct {
  _CompositeStruct({
    required this.intValue,
    required this.simpleStruct,
  }) : super._();

  final int intValue;
  final SimpleStruct simpleStruct;
}

class BCompositeStruct implements BType<CompositeStruct> {
  const BCompositeStruct();

  @override
  void write(BinaryWriter writer, CompositeStruct value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  CompositeStruct read(BinaryReader reader) {
    return CompositeStruct(
      intValue: const BU8().read(reader),
      simpleStruct: const BSimpleStruct().read(reader),
    );
  }
}

CompositeStruct _$CompositeStructFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BCompositeStruct().read(reader);
}

mixin _$StructWithOption {
  String get stringValue => throw UnimplementedError();
  String? get option => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BString().write(writer, stringValue);
    const BOption(BString()).write(writer, option);

    return writer.toArray();
  }
}

class _StructWithOption extends StructWithOption {
  _StructWithOption({
    required this.stringValue,
    required this.option,
  }) : super._();

  final String stringValue;
  final String? option;
}

class BStructWithOption implements BType<StructWithOption> {
  const BStructWithOption();

  @override
  void write(BinaryWriter writer, StructWithOption value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  StructWithOption read(BinaryReader reader) {
    return StructWithOption(
      stringValue: const BString().read(reader),
      option: const BOption(BString()).read(reader),
    );
  }
}

StructWithOption _$StructWithOptionFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BStructWithOption().read(reader);
}

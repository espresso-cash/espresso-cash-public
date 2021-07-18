// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_struct1.dart';

// **************************************************************************
// Borsh Struct Generator
// **************************************************************************

SimpleStruct1 _SimpleStruct1FromBorsh(List<int> _data) {
  ByteData _view = ByteData.sublistView(Uint8List.fromList(_data));
  int offset = 0;

  final strValue = _view.readString(offset);
  offset += 4 + strValue.length;

  final int32Value = _view.readInteger(Borsh.i32, offset);
  offset += 4;

  final fixedIntegersArray = _view.readFixedArray<int>(Borsh.u8, 3, offset);
  offset += fixedIntegersArray.length * 1;

  final dynamicStringArray =
      _view.readDynamicArray<String>(Borsh.string, offset);
  offset += 4 + dynamicStringArray.fold(0, (t, i) => t + i.length + 4);

  return SimpleStruct1(
    strValue: strValue,
    int32Value: int32Value,
    fixedIntegersArray: fixedIntegersArray,
    dynamicStringArray: dynamicStringArray,
  );
}

List<int> _SimpleStruct1ToBorsh(SimpleStruct1 s) {
  int size = 0;
  size += s.strValue.length;
  size += s.fixedIntegersArray.length * 1;
  size += s.dynamicStringArray.fold(0, (t, i) => t + i.length + 4);
  size += 12;

  final data = ByteData(size);
  int offset = 0;
  offset += data.writeString(offset, s.strValue);
  offset += data.writeInteger(Borsh.i32, offset, s.int32Value);
  offset += data.writeFixedArray<int>(Borsh.u8, offset, s.fixedIntegersArray);
  offset += data.writeDynamicArray<String>(
      Borsh.string, offset, s.dynamicStringArray);

  return data.buffer.asUint8List();
}

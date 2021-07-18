// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic1.dart';

// **************************************************************************
// Borsh Struct Generator
// **************************************************************************

_AccountData __AccountDataFromBorsh(List<int> _data) {
  ByteData _view = ByteData.sublistView(Uint8List.fromList(_data));
  int offset = 0;

  final data = _view.readInteger(Borsh.u64, offset);
  offset += 8;

  return _AccountData(
    data: data,
  );
}

List<int> _Basic1ArgumentsToBorsh(Basic1Arguments s) {
  int size = 0;
  size += 8;

  final data = ByteData(size);
  int offset = 0;
  offset += data.writeInteger(Borsh.u64, offset, s.data);

  return data.buffer.asUint8List();
}

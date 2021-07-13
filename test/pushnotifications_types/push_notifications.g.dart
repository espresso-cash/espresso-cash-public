// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notifications.dart';

// **************************************************************************
// Borsh Struct Generator
// **************************************************************************

Init _InitFromBorsh(List<int> _data) {
  ByteData _view = ByteData.sublistView(Uint8List.fromList(_data));
  int offset = 0;

  final fee = _view.readInteger(Borsh.u64, offset);
  offset += 8;

  return Init(
    fee: fee,
  );
}

List<int> _InitToBorsh(Init s) {
  int size = 0;
  size += 8;

  final data = ByteData(size);
  int offset = 0;
  offset += data.writeInteger(Borsh.u64, offset, s.fee);

  return data.buffer.asUint8List();
}

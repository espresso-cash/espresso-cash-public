// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send.dart';

// **************************************************************************
// Borsh Struct Generator
// **************************************************************************

Send _SendFromBorsh(List<int> _data) {
  ByteData _view = ByteData.sublistView(Uint8List.fromList(_data));
  int offset = 0;

  final encryptedPayload = _view.readString(offset);
  offset += 4 + encryptedPayload.length;

  final messageType = _view.readString(offset);
  offset += 4 + messageType.length;

  final notificationId = _view.readString(offset);
  offset += 4 + notificationId.length;

  return Send(
    encryptedPayload: encryptedPayload,
    messageType: messageType,
    notificationId: notificationId,
  );
}

List<int> _SendToBorsh(Send s) {
  int size = 0;
  size += s.encryptedPayload.length;
  size += s.messageType.length;
  size += s.notificationId.length;
  size += 12;

  final data = ByteData(size);
  int offset = 0;
  offset += data.writeString(offset, s.encryptedPayload);
  offset += data.writeString(offset, s.messageType);
  offset += data.writeString(offset, s.notificationId);

  return data.buffer.asUint8List();
}

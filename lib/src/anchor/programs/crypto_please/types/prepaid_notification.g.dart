// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepaid_notification.dart';

// **************************************************************************
// Borsh Struct Generator
// **************************************************************************

PrepaidNotification _PrepaidNotificationFromBorsh(List<int> _data) {
  ByteData _view = ByteData.sublistView(Uint8List.fromList(_data));
  int offset = 0;

  final notificationId = _view.readString(offset);
  offset += 4 + notificationId.length;

  return PrepaidNotification(
    notificationId: notificationId,
  );
}

List<int> _PrepaidNotificationToBorsh(PrepaidNotification s) {
  int size = 0;
  size += s.notificationId.length;
  size += 4;

  final data = ByteData(size);
  int offset = 0;
  offset += data.writeString(offset, s.notificationId);

  return data.buffer.asUint8List();
}

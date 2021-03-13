import 'dart:typed_data';

import 'package:solana_dart/src/solana_serializable/serializable.dart';

class MessageHeader extends Serializable {
  MessageHeader(
    this.numRequiredSignatures,
    this.numReadonlySignedAccounts,
    this.numReadonlyUnSignedAccounts,
  );

  final int numRequiredSignatures;
  final int numReadonlySignedAccounts;
  final int numReadonlyUnSignedAccounts;

  @override
  List<int> serialize() {
    final data = ByteData(3)
      ..setUint8(0, numRequiredSignatures)
      ..setUint8(1, numReadonlySignedAccounts)
      ..setUint8(2, numReadonlyUnSignedAccounts);
    return data.buffer.asUint8List();
  }
}

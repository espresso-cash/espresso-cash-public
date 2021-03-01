import 'dart:typed_data';

import 'package:crypto_please_solana_lib/src/types/serializable.dart';

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
    var data = ByteData(3);
    data.setUint8(0, numRequiredSignatures);
    data.setUint8(1, numReadonlySignedAccounts);
    data.setUint8(2, numReadonlyUnSignedAccounts);
    return data.buffer.asUint8List();
  }
}

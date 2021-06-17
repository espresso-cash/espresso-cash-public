import 'dart:typed_data';

import 'package:solana/src/solana_serializable/solana_serializable.dart';
import 'package:solana/src/types/account_meta.dart';

class MessageHeader extends Serializable {
  MessageHeader._(
    this.numRequiredSignatures,
    this.numReadonlySignedAccounts,
    this.numReadonlyUnSignedAccounts,
  );

  factory MessageHeader.fromAccounts(Iterable<AccountMeta> accounts) =>
      MessageHeader._(
        accounts.getNumSigners(),
        accounts.getNumReadonlySigners(),
        accounts.getNumReadonlyNonSigners(),
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

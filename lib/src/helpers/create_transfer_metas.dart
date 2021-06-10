import 'package:solana/solana.dart';
import 'package:solana/src/types/account_meta.dart';

/// Do not duplicate the account if the sender and recipient
/// are the same
List<AccountMeta> createTransferMetas(
    String sourcePubKey, String destinationPubKey) {
  if (sourcePubKey == destinationPubKey) {
    return [
      AccountMeta.writeable(pubKey: sourcePubKey, isSigner: true),
      AccountMeta.readonly(pubKey: systemProgramID, isSigner: false),
      AccountMeta.readonly(pubKey: memoProgramID, isSigner: false),
    ];
  } else {
    return [
      AccountMeta.writeable(pubKey: sourcePubKey, isSigner: true),
      AccountMeta.writeable(pubKey: destinationPubKey, isSigner: false),
      AccountMeta.readonly(pubKey: systemProgramID, isSigner: false),
      AccountMeta.readonly(pubKey: memoProgramID, isSigner: false),
    ];
  }
}

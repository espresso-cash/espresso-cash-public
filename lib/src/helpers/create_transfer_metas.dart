import 'package:solana/solana.dart';
import 'package:solana/src/types/account_meta.dart';

/// This function creates an array of [AccountMeta] objects with
/// duplicates removed.
///
/// When sender and recipient are the same, we only need to specify
/// the address once.
///
/// This function is used when creating a transfer system program
/// instruction and message for transferring from [sourcePubKey] to
/// [destinationPubKey].
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

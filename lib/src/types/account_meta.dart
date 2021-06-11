/// Class that wraps addresses with information necessary for
/// solana transactions to be encoded correctly
class AccountMeta {
  AccountMeta._({
    required this.pubKey,
    required this.isWriteable,
    required this.isSigner,
  });

  factory AccountMeta.writeable({
    required String pubKey,
    required bool isSigner,
  }) =>
      AccountMeta._(
        pubKey: pubKey,
        isWriteable: true,
        isSigner: isSigner,
      );

  factory AccountMeta.readonly({
    required String pubKey,
    required bool isSigner,
  }) =>
      AccountMeta._(
        pubKey: pubKey,
        isWriteable: false,
        isSigner: isSigner,
      );

  factory AccountMeta.fromMerge(AccountMeta a1, AccountMeta a2) {
    if (a1.pubKey != a2.pubKey) {
      throw ArgumentError("cannot merge 'AccountMeta's pubKeys must match");
    }

    return AccountMeta._(
      pubKey: a1.pubKey,
      isWriteable: a1.isWriteable || a2.isWriteable,
      isSigner: a1.isSigner || a2.isSigner,
    );
  }

  final String pubKey;
  final bool isWriteable;
  final bool isSigner;
}

/// Filter out duplicate accounts from the list of
/// accounts metadata
extension UniqueMetas on List<AccountMeta> {
  List<AccountMeta> unique() => fold([], (list, item) {
        final index = list.indexWhere((meta) => meta.pubKey == item.pubKey);
        if (index == -1) {
          return [...list, item];
        } else {
          // Keep then one of the two that is either a signer or
          // a writeable account
          list[index] = AccountMeta.fromMerge(item, list[index]);
          return list;
        }
      });

  int indexOfPubKey(String pubKey) =>
      indexWhere((meta) => meta.pubKey == pubKey);

  int getNumSigners() =>
      fold(0, (total, meta) => total + (meta.isSigner ? 1 : 0));
  int getNumReadonlySigners() => fold(
        0,
        (total, meta) => total + (!meta.isWriteable && meta.isSigner ? 1 : 0),
      );
  int getNumReadonlyNonSigners() => fold(
        0,
        (total, meta) => total + (!meta.isWriteable && !meta.isSigner ? 1 : 0),
      );
}

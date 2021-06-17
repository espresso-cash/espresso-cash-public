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

  factory AccountMeta.merged(AccountMeta a1, AccountMeta a2) {
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

extension AccountMetaListExt on Iterable<AccountMeta> {
  List<AccountMeta> unique() =>
      fold<List<AccountMeta>>([], (List<AccountMeta> list, AccountMeta item) {
        final index = list.indexOfPubKey(item.pubKey);
        if (index == -1) {
          return [...list, item];
        } else {
          // Keep then one of the two that is either a signer or
          // a writeable account
          list[index] = AccountMeta.merged(item, list[index]);

          return list;
        }
      })
        ..sort((AccountMeta a1, AccountMeta a2) {
          int score = 0;
          score += a1.isSigner ? 1 : 0;
          score += a2.isSigner ? -1 : 0;
          score += a1.isWriteable ? 1 : 0;
          score += a2.isWriteable ? -1 : 0;
          return score;
        });

  int indexOfPubKey(String pubKey) =>
      toList().indexWhere((account) => account.pubKey == pubKey);

  int getNumSigners() =>
      fold(0, (total, account) => total + (account.isSigner ? 1 : 0));
  int getNumReadonlySigners() => fold(
        0,
        (total, account) =>
            total + (!account.isWriteable && account.isSigner ? 1 : 0),
      );
  int getNumReadonlyNonSigners() => fold(
        0,
        (total, account) =>
            total + (!account.isWriteable && !account.isSigner ? 1 : 0),
      );
}

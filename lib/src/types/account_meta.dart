/// Class that wraps addresses with information necessary for
/// solana transactions to be encoded correctly
class AccountMeta {
  AccountMeta._({
    required this.pubKey,
    required this.isWriteable,
    required this.isSigner,
  });

  /// Constructs a writeable account that [isSigner] and has [pubKey] public key.
  factory AccountMeta.writeable({
    required String pubKey,
    required bool isSigner,
  }) =>
      AccountMeta._(
        pubKey: pubKey,
        isWriteable: true,
        isSigner: isSigner,
      );

  /// Constructs a readonly account that [isSigner] and has [pubKey] public key.
  factory AccountMeta.readonly({
    required String pubKey,
    required bool isSigner,
  }) =>
      AccountMeta._(
        pubKey: pubKey,
        isWriteable: false,
        isSigner: isSigner,
      );

  /// Constructs a new [AccountMeta] from two [AccountMeta]s [a1] and [a2],
  /// it combines their properties by setting [isWriteable] to [true] in case
  /// either [a1] or [a2] is writeable, and [isSigner] to [true] if either
  /// [a1] or [a2] are signers.
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
  /// Remove all duplicate accounts, meaning accounts having the same public
  /// key. Signers and/or writeable accounts are picked over non-signers and
  /// non-writeable.
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
      });

  /// Find an account with a matching [pubKey].
  int indexOfPubKey(String pubKey) =>
      toList().indexWhere((account) => account.pubKey == pubKey);

  /// Counts the number of accounts that are signers.
  int getNumSigners() =>
      fold(0, (total, account) => total + (account.isSigner ? 1 : 0));

  /// Counts the number of accounts that are signers and readonly.
  int getNumReadonlySigners() => fold(
        0,
        (total, account) =>
            total + (!account.isWriteable && account.isSigner ? 1 : 0),
      );

  /// Counts the number of accounts that are non signers and readonly.
  int getNumReadonlyNonSigners() => fold(
        0,
        (total, account) =>
            total + (!account.isWriteable && !account.isSigner ? 1 : 0),
      );
}

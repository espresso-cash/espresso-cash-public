part of 'encoder.dart';

/// Class that wraps addresses with information necessary for
/// solana transactions to be encoded correctly
class AccountMeta {
  AccountMeta({
    required this.pubKey,
    required this.isWriteable,
    required this.isSigner,
  });

  /// Constructs a writeable account that is not signer with [pubKey]
  /// public key. To make it a signing account set [isSigner] to true.
  factory AccountMeta.writeable({
    required String pubKey,
    required bool isSigner,
  }) =>
      AccountMeta(
        pubKey: pubKey,
        isWriteable: true,
        isSigner: isSigner,
      );

  /// Constructs a readonly account that is not signer has [pubKey]
  /// public key. To make it a signing account set [isSigner] to true.
  factory AccountMeta.readonly({
    required String pubKey,
    required bool isSigner,
  }) =>
      AccountMeta(
        pubKey: pubKey,
        isWriteable: false,
        isSigner: isSigner,
      );

  /// Merges a [this] with [other] by applying the following rules,
  ///
  /// Resulting [AccountMeta] is,
  ///
  /// `writeable` if either [this] or [other] is writeable
  /// `signer` if either [this] or [other] is signer.
  ///
  /// The [pubKey]s must match or it throws a [FormatException].
  ///
  /// It returns a new [AccountMeta] object.
  AccountMeta mergeWith(AccountMeta other) {
    if (pubKey != other.pubKey) {
      throw const FormatException(
        'pubKeys must match, or else it does not make sense to merge',
      );
    }

    return AccountMeta(
      pubKey: pubKey,
      isWriteable: isWriteable || other.isWriteable,
      isSigner: isSigner || other.isSigner,
    );
  }

  final String pubKey;
  final bool isWriteable;
  final bool isSigner;

  @override
  String toString() => pubKey;
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
          list[index] = item.mergeWith(list[index]);

          return list;
        }
      });

  /// Find an account with a matching [pubKey].
  int indexOfPubKey(String pubKey) =>
      toList(growable: false).indexWhere((account) => account.pubKey == pubKey);

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

/// Class that wraps addresses with information necessary for
/// solana transactions to be encoded correctly
class AccountMeta implements Comparable<AccountMeta> {
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

  /// Compare accounts according to the following rules
  ///
  /// Signer accounts go first, and within them writeable accounts
  /// go first
  ///
  /// Non-Signer accounts go after, and within them the writeable
  /// accounts go first
  @override
  int compareTo(AccountMeta other) {
    if (isSigner && !other.isSigner) return -1;
    if (!isSigner && other.isSigner) return 1;

    if (isWriteable && !other.isWriteable) return -1;
    if (!isWriteable && other.isWriteable) return 1;

    return 0;
  }
}

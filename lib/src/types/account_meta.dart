enum AccessMode {
  writeable,
  readonly,
}

class AccountMeta {
  AccountMeta._({
    required this.pubKey,
    required this.accessMode,
    required this.isSigner,
  });

  factory AccountMeta.writeable({
    required String pubKey,
    required bool isSigner,
  }) =>
      AccountMeta._(
        pubKey: pubKey,
        accessMode: AccessMode.writeable,
        isSigner: isSigner,
      );

  factory AccountMeta.readonly({
    required String pubKey,
    required bool isSigner,
  }) =>
      AccountMeta._(
        pubKey: pubKey,
        accessMode: AccessMode.readonly,
        isSigner: isSigner,
      );

  bool get isReadonlySigner => isSigner && accessMode == AccessMode.readonly;
  bool get isReadonlyNonSigner =>
      !isSigner && accessMode == AccessMode.readonly;

  final String pubKey;
  final AccessMode accessMode;
  final bool isSigner;
}

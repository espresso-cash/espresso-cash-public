part of 'encoder.dart';

extension _AccountsIterableExt on Iterable<AccountMeta> {
  // Convert account metas to encoder public keys
  Iterable<Buffer> toSerializablePubKeys() =>
      map((a) => Buffer.fromBase58(a.pubKey));
}

extension _InstructionsIterableExt on Iterable<Instruction> {
  /// Simple helper to extract all accounts from an instruction, it also appends
  /// the program id account which needs to be present in the accounts array sent
  /// in a message.
  Iterable<AccountMeta> _extractAccounts(String? feePayer) {
    final accounts = [
      for (final Instruction instruction in this) ...[
        ...instruction.accounts,
      ],
      for (final Instruction instruction in this) ...[
        AccountMeta.readonly(pubKey: instruction.programId, isSigner: false),
      ]
    ];
    if (feePayer == null) {
      return accounts;
    }
    final feePayerIndex = accounts.indexOfPubKey(feePayer);
    if (feePayerIndex == -1) {
      return [
        AccountMeta.writeable(pubKey: feePayer, isSigner: true),
        ...accounts,
      ];
    } else {
      return [
        AccountMeta.writeable(
          pubKey: feePayer,
          isSigner: true,
        ),
        ...accounts.sublist(0, feePayerIndex),
        ...accounts.sublist(feePayerIndex + 1),
      ];
    }
  }

  /// Combines accounts from every instruction and sorts them according
  /// to [Account Addresses Format][account addresses format], also removes
  /// any duplicates.
  ///
  /// Duplicates are removed by picking signers and writeable accounts
  /// over non-writeable and non-signers.
  ///
  /// Accounts are considered duplicates if they have the same public keys.
  ///
  /// [account addresses format]: https://docs.solana.com/developing/programming-model/transactions#account-addresses-format
  Iterable<AccountMeta> _getAccounts(String? feePayer) =>
      _extractAccounts(feePayer).unique()..sort(_accountComparator);
}

extension _BlockhashExt on Blockhash {
  ByteArray toBytes() => Buffer.fromBase58(blockhash);
}

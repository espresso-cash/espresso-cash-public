part of 'encoder.dart';

extension _EncodableAccountsInterableExt on Iterable<AccountMeta> {
  // Convert account metas to encoder public keys
  Iterable<PubKeyBytes> toSerializablePubKeys() =>
      map((a) => PubKeyBytes.from(a.pubKey));
}

extension _InstructionsIterableExt on Iterable<Instruction> {
  /// Simple helper to extract all accounts from an instruction, it also appends
  /// the program id account which needs to be present in the accounts array sent
  /// in a message.
  Iterable<AccountMeta> _extractAccounts() => [
        for (final Instruction instruction in this) ...[
          ...instruction.accounts,
          // Always add the program id as an account
          AccountMeta.readonly(pubKey: instruction.programId),
        ]
      ];

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
  Iterable<AccountMeta> getAccounts() =>
      _extractAccounts().unique()..sort(_accountComparator);
}

extension _BlockhashExt on Blockhash {
  ByteArray toBytes() => PubKeyBytes.from(blockhash);
}

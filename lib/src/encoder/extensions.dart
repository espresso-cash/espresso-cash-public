import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/instruction.dart';

extension AccountMetaListExt on List<AccountMeta> {
  // Convert account metas to encoder public keys
  Iterable<Buffer> toSerializablePubKeys() =>
      map((a) => Buffer.fromBase58(a.pubKey));

  Map<String, int> toIndexesMap() {
    final Map<String, int> mapped = {};

    for (int i = 0; i < length; ++i) {
      final AccountMeta item = elementAt(i);
      mapped[item.pubKey] = i;
    }

    return mapped;
  }

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

extension InstructionListExt on List<Instruction> {
  /// Simple helper to extract all accounts from an instruction, it also appends
  /// the program id account which needs to be present in the accounts array sent
  /// in a message.
  List<AccountMeta> extractAccounts(String? feePayer) {
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
  /// to [Account Addresses Format][1], also removes
  /// any duplicates.
  ///
  /// Duplicates are removed by picking signers and writeable accounts
  /// over non-writeable and non-signers.
  ///
  /// Accounts are considered duplicates if they have the same public keys.
  ///
  /// [1]: https://docs.solana.com/developing/programming-model/transactions#account-addresses-format
  List<AccountMeta> getAccounts(String? feePayer) =>
      extractAccounts(feePayer).unique()..sort();
}

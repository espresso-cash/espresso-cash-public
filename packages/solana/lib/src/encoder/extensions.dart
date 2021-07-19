import 'package:solana/solana.dart';
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
  /// Prepares all the accounts from instructions:
  ///
  /// - extracts accounts from every instruction;
  /// - appends program id accounts (accounts with the sample public keys);
  /// - removes duplicates (by picking signers and writeable accounts
  ///   over non-writeable and non-signers);
  /// - sorts accounts according to [Account Addresses Format][1].
  ///
  /// [1]: https://docs.solana.com/developing/programming-model/transactions#account-addresses-format
  List<AccountMeta> getAccountsWithOptionalFeePayer(
    Ed25519HDKeyPair feePayer,
  ) {
    final accounts = expand<AccountMeta>(
      (Instruction instruction) => [
        ...instruction.accounts,

        /// Append the instruction program id
        AccountMeta.readonly(pubKey: instruction.programId, isSigner: false),
      ],
    ).toList();
    final index = accounts.indexWhere(
      (AccountMeta account) => account.pubKey == feePayer.address,
    );
    if (index != -1) {
      // If the account is already here, remove it as we are going
      // to put it as the first element of the accounts array anyway
      accounts.removeAt(index);
    }
    // The fee payer must be the first account in they "keys" provided with
    // the message object
    accounts.insert(
      0,
      AccountMeta.writeable(pubKey: feePayer.address, isSigner: true),
    );
    return accounts.unique()..sort();
  }
}

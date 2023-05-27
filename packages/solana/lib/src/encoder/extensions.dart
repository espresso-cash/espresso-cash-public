import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/instruction.dart';

extension AccountMetaListExt on List<AccountMeta> {
  Map<Ed25519HDPublicKey, int> toIndexesMap() {
    final Map<Ed25519HDPublicKey, int> mapped = {};

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
        }

        // Keep then one of the two that is either a signer or
        // a writeable account
        list[index] = item.mergeWith(list[index]);

        return list;
      });

  /// Find an account with a matching [pubKey].
  int indexOfPubKey(Ed25519HDPublicKey pubKey) =>
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
  List<AccountMeta> getAccounts({
    required Ed25519HDPublicKey feePayer,
  }) {
    final accounts = expand<AccountMeta>(
      (Instruction instruction) => [
        ...instruction.accounts,

        /// Append the instruction program id
        AccountMeta.readonly(
          pubKey: instruction.programId,
          isSigner: false,
        ),
      ],
    ).toList();
    final index = accounts.indexWhere((account) => account.pubKey == feePayer);
    if (index != -1) {
      // If the account is already here, remove it as we are going
      // to put it as the first element of the accounts array anyway
      accounts.removeAt(index);
    }
    // The fee payer must be the first account in they "keys" provided with
    // the message object
    accounts.insert(
      0,
      AccountMeta.writeable(pubKey: feePayer, isSigner: true),
    );

    return accounts.unique()..sort();
  }
}

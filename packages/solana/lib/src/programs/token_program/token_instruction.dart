import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/token_program/token_program.dart';

enum AuthorityType {
  mintTokens,
  freezeAccount,
  accountOwner,
  closeAccount,
}

/// A spl token program instruction.
class TokenInstruction extends Instruction {
  const TokenInstruction._({
    required List<AccountMeta> accounts,
    required Iterable<int> data,
  }) : super(
          programId: TokenProgram.programId,
          accounts: accounts,
          data: data,
        );

  /// Construct an instruction to initialize a new spl token with address [mint],
  /// [decimals] decimal places, and [mintAuthority] as the mint authority.
  ///
  /// You can use [RPCClient.getMinimumBalanceForRentExemption]
  /// to determine [rent] for the required [space].
  ///
  /// The [freezeAuthority] is optional and can be used to specify a the
  /// freeze authority for this token.
  factory TokenInstruction.initializeMint({
    required int decimals,
    required String mint,
    required String mintAuthority,
    String? freezeAuthority,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.initializeMintInstructionIndex,
          Buffer.fromUint8(decimals),
          Buffer.fromBase58(mintAuthority),
          Buffer.fromUint8(freezeAuthority != null ? 1 : 0),
          if (freezeAuthority != null)
            Buffer.fromBase58(freezeAuthority)
          else
            List<int>.filled(32, 0),
        ]),
      );

  /// Construct an instruction to initialize a new account to hold tokens for
  /// [mint].
  ///
  /// The new account [pubKey] must be created using the corresponding system
  /// instruction.
  factory TokenInstruction.initializeAccount({
    required String pubKey,
    required String mint,
    required String owner,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: owner, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: TokenProgram.initializeAccountInstructionIndex,
      );

  factory TokenInstruction.initializeMultisig({
    required String pubKey,
    required List<String> signerPubKeys,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
          ...signerPubKeys.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.initializeMintInstructionIndex,
          Buffer.fromUint8(signerPubKeys.length),
        ]),
      );

  factory TokenInstruction.transfer({
    required int amount,
    required String source,
    required String destination,
    required String owner,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
          AccountMeta.readonly(
            pubKey: owner,
            isSigner: signers.length == 0,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.transferInstructionIndex,
          Buffer.fromUint64(amount),
        ]),
      );

  factory TokenInstruction.approve({
    required int amount,
    required String source,
    required String delegate,
    required String sourceOwner,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
          accounts: [
            AccountMeta.writeable(pubKey: source, isSigner: false),
            AccountMeta.readonly(pubKey: delegate, isSigner: false),
            AccountMeta.readonly(
              pubKey: sourceOwner,
              isSigner: signers.length == 0,
            ),
            ...signers.map(
              (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
            )
          ],
          data: Buffer.fromConcatenatedByteArrays([
            TokenProgram.approveInstructionIndex,
            Buffer.fromUint64(amount)
          ]));

  factory TokenInstruction.revoke({
    required String source,
    required String sourceOwner,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.readonly(
            pubKey: sourceOwner,
            isSigner: signers.length == 0,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: TokenProgram.revokeInstructionIndex,
      );

  factory TokenInstruction.setAuthority({
    required String mintOrAccount,
    required String currentAuthority,
    required AuthorityType authorityType,
    required String newAuthority,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mintOrAccount, isSigner: false),
          AccountMeta.readonly(
            pubKey: currentAuthority,
            isSigner: signers.length == 0,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.setAuthorityInstructionIndex,
          Buffer.fromUint8(authorityType.value),
          Buffer.fromBase58(newAuthority),
        ]),
      );

  /// Mint the [destination] account with [amount] tokens of the [mint] token.
  /// The [authority] is the mint authority of the token.
  ///
  /// The [destination] account must exist and be linked with [mint]. You can create
  /// it by using [TokenProgram.createAccount].
  factory TokenInstruction.mintTo({
    required int amount,
    required String mint,
    required String destination,
    required String authority,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
          // TODO(IA): this should be readonly unless, it is the fee payer
          AccountMeta.writeable(pubKey: authority, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.mintToInstructionIndex,
          Buffer.fromUint64(amount),
        ]),
      );

  factory TokenInstruction.burn({
    required int amount,
    required String accountToBurnFrom,
    required String mint,
    required String owner,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: accountToBurnFrom, isSigner: false),
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(
            pubKey: owner,
            isSigner: signers.length == 0,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.burnInstructionIndex,
            Buffer.fromUint64(amount),
          ],
        ),
      );

  factory TokenInstruction.closeAccount({
    required String accountToClose,
    required String destination,
    required String owner,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: accountToClose, isSigner: false),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
          AccountMeta.writeable(
            pubKey: owner,
            isSigner: signers.length == 0,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: TokenProgram.closeAccountInstructionIndex,
      );

  factory TokenInstruction.freezeAccount({
    required String accountToFreeze,
    required String mint,
    required String freezeAuthority,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: accountToFreeze, isSigner: false),
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(
            pubKey: freezeAuthority,
            isSigner: signers.length == 0,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: TokenProgram.freezeAccountInstructionIndex,
      );

  factory TokenInstruction.thawAccount({
    required String accountToFreeze,
    required String mint,
    required String freezeAuthority,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: accountToFreeze, isSigner: false),
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(
            pubKey: freezeAuthority,
            isSigner: signers.length == 0,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: TokenProgram.thawAccountInstructionIndex,
      );

  factory TokenInstruction.transferChecked({
    required int amount,
    required int decimals,
    required String source,
    required String mint,
    required String destination,
    required String owner,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
          AccountMeta.readonly(
            pubKey: owner,
            isSigner: signers.length == 0,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.transferCheckedInstructionIndex,
            Buffer.fromUint64(amount),
            Buffer.fromUint8(decimals),
          ],
        ),
      );

  factory TokenInstruction.approveChecked({
    required int amount,
    required int decimals,
    required String mint,
    required String source,
    required String delegate,
    required String sourceOwner,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: delegate, isSigner: false),
          AccountMeta.readonly(
            pubKey: sourceOwner,
            isSigner: signers.length == 0,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.approveCheckedInstructionIndex,
            Buffer.fromUint64(amount),
            Buffer.fromUint8(decimals),
          ],
        ),
      );

  factory TokenInstruction.mintToChecked({
    required int amount,
    required int decimals,
    required String mint,
    required String destination,
    required String authority,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
          // TODO(IA): this should be readonly unless, it is the fee payer
          AccountMeta.writeable(pubKey: authority, isSigner: true),
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.mintToCheckedInstructionIndex,
            Buffer.fromUint64(amount),
            Buffer.fromUint8(decimals),
          ],
        ),
      );

  factory TokenInstruction.burnChecked({
    required int amount,
    required int decimals,
    required String accountToBurnFrom,
    required String mint,
    required String owner,
    List<String> signers = const <String>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: accountToBurnFrom, isSigner: false),
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(
            pubKey: owner,
            isSigner: signers.length == 0,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.burnCheckedInstructionIndex,
            Buffer.fromUint64(amount),
            Buffer.fromUint8(decimals),
          ],
        ),
      );

  factory TokenInstruction.initializeAccount2({
    required String pubKey,
    required String mint,
    required String owner,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.initializeAccount2InstructionIndex,
            Buffer.fromBase58(owner),
          ],
        ),
      );

  factory TokenInstruction.syncNative({
    required String nativeTokenAccount,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: nativeTokenAccount, isSigner: false)
        ],
        data: TokenProgram.syncNativeInstructionIndex,
      );

  factory TokenInstruction.initializeAccount3({
    required String pubKey,
    required String mint,
    required String owner,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.initializeAccount3InstructionIndex,
            Buffer.fromBase58(owner),
          ],
        ),
      );

  factory TokenInstruction.initializeMultisig2({
    required String pubKey,
    required List<String> signerPubKeys,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
          ...signerPubKeys.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.initializeMultisig2InstructionIndex,
          Buffer.fromUint8(signerPubKeys.length),
        ]),
      );

  factory TokenInstruction.initializeMint2({
    required int decimals,
    required String mint,
    required String mintAuthority,
    String? freezeAuthority,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.initializeMint2InstructionIndex,
            Buffer.fromUint8(decimals),
            Buffer.fromBase58(mintAuthority),
            Buffer.fromUint8(freezeAuthority != null ? 1 : 0),
            if (freezeAuthority != null)
              Buffer.fromBase58(freezeAuthority)
            else
              List<int>.filled(32, 0),
          ],
        ),
      );
}

extension on AuthorityType {
  int get value {
    switch (this) {
      case AuthorityType.mintTokens:
        return 0;
      case AuthorityType.freezeAccount:
        return 1;
      case AuthorityType.accountOwner:
        return 2;
      case AuthorityType.closeAccount:
        return 3;
    }
  }
}

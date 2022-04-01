import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/system_program/system_instruction.dart';
import 'package:solana/src/programs/token_program/token_program.dart';

enum AuthorityType {
  mintTokens,
  freezeAccount,
  accountOwner,
  closeAccount,
}

/// A spl token program instruction.
class TokenInstruction extends Instruction {
  TokenInstruction._({
    required List<AccountMeta> accounts,
    required Iterable<int> data,
  }) : super(
          programId: TokenProgram.id,
          accounts: accounts,
          data: data,
        );

  /// Construct an instruction to initialize a new spl token with address
  /// [mint], [decimals] decimal places, and [mintAuthority] as the mint
  /// authority.
  ///
  /// You can use `RPCClient.getMinimumBalanceForRentExemption` to determine
  /// rent for the required space.
  ///
  /// The [freezeAuthority] is optional and can be used to specify a the freeze
  /// authority for this token.
  factory TokenInstruction.initializeMint({
    required int decimals,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey mintAuthority,
    Ed25519HDPublicKey? freezeAuthority,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.initializeMintInstructionIndex,
          Buffer.fromUint8(decimals),
          mintAuthority.toBuffer(),
          Buffer.fromUint8(freezeAuthority != null ? 1 : 0),
          if (freezeAuthority != null)
            freezeAuthority.toBuffer()
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
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey owner,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: owner, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
        ],
        data: TokenProgram.initializeAccountInstructionIndex,
      );

  factory TokenInstruction.initializeMultisig({
    required Ed25519HDPublicKey pubKey,
    required List<Ed25519HDPublicKey> signerPubKeys,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
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
    required Ed25519HDPublicKey source,
    required Ed25519HDPublicKey destination,
    required Ed25519HDPublicKey owner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
          AccountMeta.readonly(
            pubKey: owner,
            isSigner: signers.isEmpty,
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
    required Ed25519HDPublicKey source,
    required Ed25519HDPublicKey delegate,
    required Ed25519HDPublicKey sourceOwner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.readonly(pubKey: delegate, isSigner: false),
          AccountMeta.readonly(
            pubKey: sourceOwner,
            isSigner: signers.isEmpty,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [TokenProgram.approveInstructionIndex, Buffer.fromUint64(amount)],
        ),
      );

  factory TokenInstruction.revoke({
    required Ed25519HDPublicKey source,
    required Ed25519HDPublicKey sourceOwner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.readonly(
            pubKey: sourceOwner,
            isSigner: signers.isEmpty,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: TokenProgram.revokeInstructionIndex,
      );

  factory TokenInstruction.setAuthority({
    required Ed25519HDPublicKey mintOrAccount,
    required Ed25519HDPublicKey currentAuthority,
    required AuthorityType authorityType,
    required Ed25519HDPublicKey newAuthority,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mintOrAccount, isSigner: false),
          AccountMeta.readonly(
            pubKey: currentAuthority,
            isSigner: signers.isEmpty,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.setAuthorityInstructionIndex,
          Buffer.fromUint32(authorityType.value),
          newAuthority.toBuffer(),
        ]),
      );

  /// Mint the [destination] account with [amount] tokens of the [mint] token.
  /// The [authority] is the mint authority of the token.
  ///
  /// The [destination] account must exist and be linked with [mint]. You can
  /// create it by using `TokenProgram.createAccount`.
  factory TokenInstruction.mintTo({
    required int amount,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey destination,
    required Ed25519HDPublicKey authority,
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
    required Ed25519HDPublicKey accountToBurnFrom,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey owner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: accountToBurnFrom, isSigner: false),
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(
            pubKey: owner,
            isSigner: signers.isEmpty,
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
    required Ed25519HDPublicKey accountToClose,
    required Ed25519HDPublicKey destination,
    required Ed25519HDPublicKey owner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: accountToClose, isSigner: false),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
          AccountMeta.writeable(
            pubKey: owner,
            isSigner: signers.isEmpty,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: TokenProgram.closeAccountInstructionIndex,
      );

  factory TokenInstruction.freezeAccount({
    required Ed25519HDPublicKey accountToFreeze,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey freezeAuthority,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: accountToFreeze, isSigner: false),
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(
            pubKey: freezeAuthority,
            isSigner: signers.isEmpty,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: TokenProgram.freezeAccountInstructionIndex,
      );

  factory TokenInstruction.thawAccount({
    required Ed25519HDPublicKey accountToFreeze,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey freezeAuthority,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: accountToFreeze, isSigner: false),
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(
            pubKey: freezeAuthority,
            isSigner: signers.isEmpty,
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
    required Ed25519HDPublicKey source,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey destination,
    required Ed25519HDPublicKey owner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(pubKey: destination, isSigner: false),
          AccountMeta.readonly(
            pubKey: owner,
            isSigner: signers.isEmpty,
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
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey source,
    required Ed25519HDPublicKey delegate,
    required Ed25519HDPublicKey sourceOwner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: source, isSigner: false),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: delegate, isSigner: false),
          AccountMeta.readonly(
            pubKey: sourceOwner,
            isSigner: signers.isEmpty,
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
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey destination,
    required Ed25519HDPublicKey authority,
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
    required Ed25519HDPublicKey accountToBurnFrom,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey owner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: accountToBurnFrom, isSigner: false),
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.writeable(
            pubKey: owner,
            isSigner: signers.isEmpty,
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
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey owner,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.initializeAccount2InstructionIndex,
            owner.toBuffer(),
          ],
        ),
      );

  factory TokenInstruction.syncNative({
    required Ed25519HDPublicKey nativeTokenAccount,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: nativeTokenAccount, isSigner: false)
        ],
        data: TokenProgram.syncNativeInstructionIndex,
      );

  factory TokenInstruction.initializeAccount3({
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey owner,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.initializeAccount3InstructionIndex,
            owner.toBuffer(),
          ],
        ),
      );

  factory TokenInstruction.initializeMultisig2({
    required Ed25519HDPublicKey pubKey,
    required List<Ed25519HDPublicKey> signerPubKeys,
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
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey mintAuthority,
    Ed25519HDPublicKey? freezeAuthority,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays(
          [
            TokenProgram.initializeMint2InstructionIndex,
            Buffer.fromUint8(decimals),
            mintAuthority.toBuffer(),
            Buffer.fromUint8(freezeAuthority != null ? 1 : 0),
            if (freezeAuthority != null)
              freezeAuthority.toBuffer()
            else
              List<int>.filled(32, 0),
          ],
        ),
      );

  /// Initialize a new spl token with address [mint], [decimals] decimal places,
  /// and [mintAuthority] as the mint authority.
  ///
  /// You can use `RPCClient.getMinimumBalanceForRentExemption` to determine
  /// [rent] for the required [space].
  ///
  /// The [freezeAuthority] is optional and can be used to specify a the freeze
  /// authority for this token.
  static List<Instruction> createAccountAndInitializeMint({
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey mintAuthority,
    required int rent,
    required int space,
    required int decimals,
    Ed25519HDPublicKey? freezeAuthority,
  }) =>
      [
        SystemInstruction.createAccount(
          pubKey: mint,
          fromPubKey: mintAuthority,
          lamports: rent,
          space: space,
          owner: Ed25519HDPublicKey.fromBase58(TokenProgram.programId),
        ),
        TokenInstruction.initializeMint(
          mint: mint,
          decimals: decimals,
          mintAuthority: mintAuthority,
          freezeAuthority: freezeAuthority,
        ),
      ];

  /// Create an account with [address] and owned by [owner]. The [rent]
  ///
  /// You can use `RPCClient.getMinimumBalanceForRentExemption` to determine
  /// [rent] for the required [space].
  ///
  /// This is a convenience method that would initialize the account and
  /// associate it with [mint]. This method also issues a [SystemInstruction] to
  /// actually create the account before linking it with the [mint].
  ///
  /// You must call this method and create an account before attempting to use
  /// it in the `TokenProgram.mintTo` as destination.
  ///
  /// This transaction must be signed by [owner] and [address].
  static List<Instruction> createAndInitializeAccount({
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey address,
    required Ed25519HDPublicKey owner,
    required int rent,
    required int space,
  }) =>
      [
        SystemInstruction.createAccount(
          pubKey: address,
          fromPubKey: owner,
          lamports: rent,
          space: space,
          owner: Ed25519HDPublicKey.fromBase58(TokenProgram.programId),
        ),
        TokenInstruction.initializeAccount(
          mint: mint,
          pubKey: address,
          owner: owner,
        ),
      ];
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

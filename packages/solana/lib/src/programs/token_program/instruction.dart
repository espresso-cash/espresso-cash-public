import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/system_program/instruction.dart';
import 'package:solana/src/programs/token_program/program.dart';

enum AuthorityType {
  mintTokens,
  freezeAccount,
  accountOwner,
  closeAccount,
}

/// A spl token program instruction.
class TokenInstruction extends Instruction {
  TokenInstruction._({
    required super.accounts,
    required super.data,
  }) : super(
          programId: TokenProgram.id,
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
        data: ByteArray.merge([
          TokenProgram.initializeMintInstructionIndex,
          ByteArray.u8(decimals),
          mintAuthority.toByteArray(),
          ByteArray.u8(freezeAuthority != null ? 1 : 0),
          if (freezeAuthority != null)
            freezeAuthority.toByteArray()
          else
            ByteArray(List<int>.filled(32, 0)),
        ]),
      );

  /// Initializes a new [account] to hold tokens.
  ///
  /// If this account is associated with the native mint then the token balance
  /// of the initialized account will be equal to the amount of SOL in the
  /// account. If this account is associated with another mint, that mint must
  /// be initialized before this command can succeed.
  factory TokenInstruction.initializeAccount({
    required Ed25519HDPublicKey account,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey owner,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: account, isSigner: true),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: owner, isSigner: false),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
        ],
        data: TokenProgram.initializeAccountInstructionIndex,
      );

  /// Initializes a multisignature [account] with N provided [signers].
  ///
  /// Multisignature accounts can be used in place of any single owner/delegate
  /// accounts in any token instruction that require an owner/delegate to be
  /// present.
  factory TokenInstruction.initializeMultisig({
    required Ed25519HDPublicKey account,
    required List<Ed25519HDPublicKey> signers,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: account, isSigner: true),
          AccountMeta.readonly(
            pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
            isSigner: false,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          )
        ],
        data: ByteArray.merge([
          TokenProgram.initializeMintInstructionIndex,
          ByteArray.u8(signers.length),
        ]),
      );

  /// Transfers tokens from one [source] account to [destination] either
  /// directly or via a delegate.
  ///
  /// If this account is associated with the native mint then equal amounts of
  /// SOL and Tokens will be transferred to the [destination] account.
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
        data: ByteArray.merge([
          TokenProgram.transferInstructionIndex,
          ByteArray.u64(amount),
        ]),
      );

  /// Approves a [delegate].
  ///
  /// A delegate is given the authority over tokens on behalf of the account's
  /// [sourceOwner].
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
        data: ByteArray.merge(
          [
            TokenProgram.approveInstructionIndex,
            ByteArray.u64(amount),
          ],
        ),
      );

  /// Revokes the delegate's authority.
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

  /// Sets a new authority of a mint or account.
  ///
  /// The [newAuthority] is optional and can be used to specify a new
  /// authority for this token.
  factory TokenInstruction.setAuthority({
    required Ed25519HDPublicKey mintOrAccount,
    required Ed25519HDPublicKey currentAuthority,
    required AuthorityType authorityType,
    Ed25519HDPublicKey? newAuthority,
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
        data: ByteArray.merge([
          TokenProgram.setAuthorityInstructionIndex,
          ByteArray.u8(authorityType.value),
          if (newAuthority != null) ...[
            ByteArray.u8(1),
            newAuthority.toByteArray(),
          ] else
            ByteArray.u8(0),
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
        data: ByteArray.merge([
          TokenProgram.mintToInstructionIndex,
          ByteArray.u64(amount),
        ]),
      );

  /// Burns tokens by removing them from an account.
  ///
  /// `Burn` does not support accounts associated with the native mint, use
  /// `CloseAccount` instead.
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
        data: ByteArray.merge([
          TokenProgram.burnInstructionIndex,
          ByteArray.u64(amount),
        ]),
      );

  /// Close an account by transferring all its SOL to the destination account.
  ///
  /// Non-native accounts may only be closed if its token amount is zero.
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

  /// Freeze an Initialized [account] using the mint's [freezeAuthority].
  factory TokenInstruction.freezeAccount({
    required Ed25519HDPublicKey account,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey freezeAuthority,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: account, isSigner: false),
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

  /// Thaw a Frozen [account] using the mint's [freezeAuthority].
  factory TokenInstruction.thawAccount({
    required Ed25519HDPublicKey account,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey freezeAuthority,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: account, isSigner: false),
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

  /// Transfers tokens from one account to another either directly or via a
  /// delegate.  If this account is associated with the native mint then equal
  /// amounts of SOL and Tokens will be transferred to the destination account.
  ///
  /// This instruction differs from [TokenInstruction.transfer] in that the
  /// token mint and decimals value is checked by the caller. This may be useful
  /// when creating transactions offline or within a hardware wallet.
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
        data: ByteArray.merge([
          TokenProgram.transferCheckedInstructionIndex,
          ByteArray.u64(amount),
          ByteArray.u8(decimals),
        ]),
      );

  /// Approves a delegate. A delegate is given the authority over tokens on
  /// behalf of the source account's owner.
  ///
  /// This instruction differs from [TokenInstruction.approve] in that the token
  /// mint and decimals value is checked by the caller.  This may be useful when
  /// creating transactions offline or within a hardware wallet.
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
        data: ByteArray.merge(
          [
            TokenProgram.approveCheckedInstructionIndex,
            ByteArray.u64(amount),
            ByteArray.u8(decimals),
          ],
        ),
      );

  /// Mints new tokens to an account. The native mint does not support minting.
  ///
  /// This instruction differs from [TokenInstruction.mintTo] in that the
  /// decimals value is checked by the caller. This may be useful when creating
  /// transactions offline or within a hardware wallet.
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
        data: ByteArray.merge([
          TokenProgram.mintToCheckedInstructionIndex,
          ByteArray.u64(amount),
          ByteArray.u8(decimals),
        ]),
      );

  /// Burns tokens by removing them from an account.
  ///
  /// [TokenInstruction.burnChecked] does not support accounts associated with
  /// the native mint, use [TokenInstruction.closeAccount] instead.
  ///
  /// This instruction differs from [TokenInstruction.burn] in that the decimals
  /// value is checked by the caller. This may be useful when creating
  /// transactions offline or within a hardware wallet.
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
        data: ByteArray.merge([
          TokenProgram.burnCheckedInstructionIndex,
          ByteArray.u64(amount),
          ByteArray.u8(decimals),
        ]),
      );

  /// Like [TokenInstruction.initializeAccount], but the owner pubkey is passed
  /// via instruction data rather than the accounts list. This variant may be
  /// preferable when using Cross Program Invocation from an instruction that
  /// does not need the owner's `AccountInfo` otherwise.
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
        data: ByteArray.merge([
          TokenProgram.initializeAccount2InstructionIndex,
          owner.toByteArray(),
        ]),
      );

  /// Given a wrapped / native token account (a token account containing SOL)
  /// updates its amount field based on the account's underlying `lamports`.
  /// This is useful if a non-wrapped SOL account uses
  /// [SystemInstruction.transfer] to move lamports to a wrapped token account,
  /// and needs to have its token `amount` field updated.
  factory TokenInstruction.syncNative({
    required Ed25519HDPublicKey nativeTokenAccount,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: nativeTokenAccount, isSigner: false)
        ],
        data: TokenProgram.syncNativeInstructionIndex,
      );

  /// Like [TokenInstruction.initializeAccount2], but does not require the Rent
  /// sysvar to be provided.
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
        data: ByteArray.merge([
          TokenProgram.initializeAccount3InstructionIndex,
          owner.toByteArray(),
        ]),
      );

  /// Like [TokenInstruction.initializeMultisig], but does not require the Rent
  /// sysvar to be provided.
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
        data: ByteArray.merge([
          TokenProgram.initializeMultisig2InstructionIndex,
          ByteArray.u8(signerPubKeys.length),
        ]),
      );

  /// Like [TokenInstruction.initializeMint], but does not require the Rent
  /// sysvar to be provided.
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
        data: ByteArray.merge([
          TokenProgram.initializeMint2InstructionIndex,
          ByteArray.u8(decimals),
          mintAuthority.toByteArray(),
          ByteArray.u8(freezeAuthority != null ? 1 : 0),
          if (freezeAuthority != null)
            freezeAuthority.toByteArray()
          else
            ByteArray(List<int>.filled(32, 0)),
        ]),
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
          newAccount: mint,
          fundingAccount: mintAuthority,
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
          newAccount: address,
          fundingAccount: owner,
          lamports: rent,
          space: space,
          owner: Ed25519HDPublicKey.fromBase58(TokenProgram.programId),
        ),
        TokenInstruction.initializeAccount(
          mint: mint,
          account: address,
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

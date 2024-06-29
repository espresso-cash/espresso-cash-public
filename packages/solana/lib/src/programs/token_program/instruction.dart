import 'package:solana/solana.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';

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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
  }) : super(
          programId: tokenProgramType.id,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
        tokenProgramType: tokenProgramType,
      );

  /// Initializes a multisignature [account] with N provided [signers].
  ///
  /// Multisignature accounts can be used in place of any single owner/delegate
  /// accounts in any token instruction that require an owner/delegate to be
  /// present.
  factory TokenInstruction.initializeMultisig({
    required Ed25519HDPublicKey account,
    required List<Ed25519HDPublicKey> signers,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: ByteArray.merge([
          TokenProgram.initializeMintInstructionIndex,
          ByteArray.u8(signers.length),
        ]),
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: ByteArray.merge([
          TokenProgram.transferInstructionIndex,
          ByteArray.u64(amount),
        ]),
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: ByteArray.merge(
          [
            TokenProgram.approveInstructionIndex,
            ByteArray.u64(amount),
          ],
        ),
        tokenProgramType: tokenProgramType,
      );

  /// Revokes the delegate's authority.
  factory TokenInstruction.revoke({
    required Ed25519HDPublicKey source,
    required Ed25519HDPublicKey sourceOwner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: TokenProgram.revokeInstructionIndex,
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
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
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: ByteArray.merge([
          TokenProgram.burnInstructionIndex,
          ByteArray.u64(amount),
        ]),
        tokenProgramType: tokenProgramType,
      );

  /// Close an account by transferring all its SOL to the destination account.
  ///
  /// Non-native accounts may only be closed if its token amount is zero.
  factory TokenInstruction.closeAccount({
    required Ed25519HDPublicKey accountToClose,
    required Ed25519HDPublicKey destination,
    required Ed25519HDPublicKey owner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: TokenProgram.closeAccountInstructionIndex,
        tokenProgramType: tokenProgramType,
      );

  /// Freeze an Initialized [account] using the mint's [freezeAuthority].
  factory TokenInstruction.freezeAccount({
    required Ed25519HDPublicKey account,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey freezeAuthority,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: TokenProgram.freezeAccountInstructionIndex,
        tokenProgramType: tokenProgramType,
      );

  /// Thaw a Frozen [account] using the mint's [freezeAuthority].
  factory TokenInstruction.thawAccount({
    required Ed25519HDPublicKey account,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey freezeAuthority,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: TokenProgram.thawAccountInstructionIndex,
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: ByteArray.merge([
          TokenProgram.transferCheckedInstructionIndex,
          ByteArray.u64(amount),
          ByteArray.u8(decimals),
        ]),
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: ByteArray.merge(
          [
            TokenProgram.approveCheckedInstructionIndex,
            ByteArray.u64(amount),
            ByteArray.u8(decimals),
          ],
        ),
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
          ),
        ],
        data: ByteArray.merge([
          TokenProgram.burnCheckedInstructionIndex,
          ByteArray.u64(amount),
          ByteArray.u8(decimals),
        ]),
        tokenProgramType: tokenProgramType,
      );

  /// Like [TokenInstruction.initializeAccount], but the owner pubkey is passed
  /// via instruction data rather than the accounts list. This variant may be
  /// preferable when using Cross Program Invocation from an instruction that
  /// does not need the owner's `AccountInfo` otherwise.
  factory TokenInstruction.initializeAccount2({
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey owner,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
        tokenProgramType: tokenProgramType,
      );

  /// Given a wrapped / native token account (a token account containing SOL)
  /// updates its amount field based on the account's underlying `lamports`.
  /// This is useful if a non-wrapped SOL account uses
  /// [SystemInstruction.transfer] to move lamports to a wrapped token account,
  /// and needs to have its token `amount` field updated.
  factory TokenInstruction.syncNative({
    required Ed25519HDPublicKey nativeTokenAccount,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: nativeTokenAccount, isSigner: false),
        ],
        data: TokenProgram.syncNativeInstructionIndex,
        tokenProgramType: tokenProgramType,
      );

  /// Like [TokenInstruction.initializeAccount2], but does not require the Rent
  /// sysvar to be provided.
  factory TokenInstruction.initializeAccount3({
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey owner,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
        tokenProgramType: tokenProgramType,
      );

  /// Like [TokenInstruction.initializeMultisig], but does not require the Rent
  /// sysvar to be provided.
  factory TokenInstruction.initializeMultisig2({
    required Ed25519HDPublicKey pubKey,
    required List<Ed25519HDPublicKey> signerPubKeys,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: pubKey, isSigner: true),
          ...signerPubKeys.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          ),
        ],
        data: ByteArray.merge([
          TokenProgram.initializeMultisig2InstructionIndex,
          ByteArray.u8(signerPubKeys.length),
        ]),
        tokenProgramType: tokenProgramType,
      );

  /// Like [TokenInstruction.initializeMint], but does not require the Rent
  /// sysvar to be provided.
  factory TokenInstruction.initializeMint2({
    required int decimals,
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey mintAuthority,
    Ed25519HDPublicKey? freezeAuthority,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
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
        tokenProgramType: tokenProgramType,
      );

  /// Gets the required size of an account for the given mint as a
  /// little-endian `u64`.
  factory TokenInstruction.getAccountDataSize({
    required Ed25519HDPublicKey mint,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.readonly(pubKey: mint, isSigner: false),
        ],
        data: TokenProgram.getAccountDataSizeInstructionIndex,
        tokenProgramType: tokenProgramType,
      );

  /// Initialize the Immutable Owner extension for the given token account
  ///
  /// Fails if the account has already been initialized, so must be called
  /// before [TokenInstruction.initializeAccount].
  factory TokenInstruction.initializeImmutableOwner({
    required Ed25519HDPublicKey account,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: account, isSigner: false),
        ],
        data: TokenProgram.initializeImmutableOwnerInstructionIndex,
        tokenProgramType: tokenProgramType,
      );

  /// Convert an [amount] of tokens to a UiAmount `string`, using the given
  /// mint. In this version of the program, the [mint] can only specify the
  /// number of decimals.
  ///
  /// Fails on an invalid mint.
  factory TokenInstruction.amountToUiAmount({
    required Ed25519HDPublicKey mint,
    required int amount,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.readonly(pubKey: mint, isSigner: false),
        ],
        data: ByteArray.merge(
          [
            TokenProgram.amountToUiAmountInstructionIndex,
            ByteArray.u64(amount),
          ],
        ),
        tokenProgramType: tokenProgramType,
      );

  /// Convert a UiAmount of tokens to a little-endian `u64` raw [amount], using
  /// the given [mint].
  factory TokenInstruction.uiAmountToAmount({
    required Ed25519HDPublicKey mint,
    required String amount,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.readonly(pubKey: mint, isSigner: false),
        ],
        data: ByteArray.merge(
          [
            TokenProgram.uiAmountToAmountInstructionIndex,
            ByteArray.fromString(amount),
          ],
        ),
        tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
  }) =>
      [
        SystemInstruction.createAccount(
          newAccount: mint,
          fundingAccount: mintAuthority,
          lamports: rent,
          space: space,
          owner: Ed25519HDPublicKey.fromBase58(tokenProgramType.programId),
        ),
        TokenInstruction.initializeMint(
          mint: mint,
          decimals: decimals,
          mintAuthority: mintAuthority,
          freezeAuthority: freezeAuthority,
          tokenProgramType: tokenProgramType,
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
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
  }) =>
      [
        SystemInstruction.createAccount(
          newAccount: address,
          fundingAccount: owner,
          lamports: rent,
          space: space,
          owner: Ed25519HDPublicKey.fromBase58(tokenProgramType.programId),
        ),
        TokenInstruction.initializeAccount(
          mint: mint,
          account: address,
          owner: owner,
          tokenProgramType: tokenProgramType,
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

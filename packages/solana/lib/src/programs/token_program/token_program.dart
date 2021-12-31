import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/programs/system_program/system_program.dart';
import 'package:solana/src/programs/token_program/token_instruction.dart';

export 'package:solana/src/programs/token_program/token_instruction.dart';

/// Construct token programs conveniently
class TokenProgram extends Message {
  TokenProgram._({
    required List<Instruction> instructions,
  }) : super(
          instructions: instructions,
        );

  /// Initialize a new spl token with address [mint], [decimals] decimal places,
  /// and [mintAuthority] as the mint authority.
  ///
  /// You can use [RPCClient.getMinimumBalanceForRentExemption]
  /// to determine [rent] for the required [space].
  ///
  /// The [freezeAuthority] is optional and can be used to specify a the
  /// freeze authority for this token.
  factory TokenProgram.initializeMint({
    required String mint,
    required String mintAuthority,
    required int rent,
    required int space,
    required int decimals,
    String? freezeAuthority,
  }) =>
      TokenProgram._(
        instructions: [
          SystemInstruction.createAccount(
            address: mint,
            owner: mintAuthority,
            rent: rent,
            space: space,
            programId: TokenProgram.programId,
          ),
          TokenInstruction.initializeMint(
            mint: mint,
            decimals: decimals,
            mintAuthority: mintAuthority,
            freezeAuthority: freezeAuthority,
          ),
        ],
      );

  /// Create an account with [address] and owned by [owner]. The [rent]
  ///
  /// You can use [RPCClient.getMinimumBalanceForRentExemption]
  /// to determine [rent] for the required [space].
  ///
  /// This is a convenience method that would initialize the account and associate it
  /// with [mint]. This method also issues a [SystemInstruction] to actually create
  /// the account before linking it with the [mint].
  ///
  /// You must call this method and create an account before attempting to use it
  /// in the [TokenProgram.mintTo] as destination.
  ///
  /// This transaction must be signed by [owner] and [address].
  factory TokenProgram.createAccount({
    required String mint,
    required String address,
    required String owner,
    required int rent,
    required int space,
  }) =>
      TokenProgram._(
        instructions: [
          SystemInstruction.createAccount(
            address: address,
            owner: owner,
            rent: rent,
            space: space,
            programId: TokenProgram.programId,
          ),
          TokenInstruction.initializeAccount(
            mint: mint,
            pubKey: address,
            owner: owner,
          ),
        ],
      );

  /// Mint the [destination] account with [amount] tokens of the [mint] token.
  /// The [authority] is the mint authority of the token and must sign the
  /// transaction.
  ///
  /// The [destination] account must exist and be linked with [mint]. You can create
  /// it by using [TokenProgram.createAccount].
  factory TokenProgram.mintTo({
    required String mint,
    required String destination,
    required String authority,
    required int amount,
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.mintTo(
            mint: mint,
            destination: destination,
            authority: authority,
            amount: amount,
          ),
        ],
      );

  factory TokenProgram.mintToChecked({
    required String mint,
    required String destination,
    required String authority,
    required int amount,
    required int decimals,
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.mintToChecked(
            mint: mint,
            destination: destination,
            authority: authority,
            amount: amount,
            decimals: decimals,
          ),
        ],
      );

  /// Construct a program to transfer [amount] tokens owned by [owner]
  /// from the associated token address [source] to the associated token address
  /// [destination].

  /// Note that often the [owner] is the same account as [source].
  factory TokenProgram.transfer({
    required String source,
    required String destination,
    required String owner,
    required int amount,
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.transfer(
            source: source,
            destination: destination,
            owner: owner,
            amount: amount,
          )
        ],
      );

  factory TokenProgram.transferChecked({
    required String mint,
    required String source,
    required String destination,
    required String owner,
    required int amount,
    required int decimals,
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.transferChecked(
            source: source,
            mint: mint,
            destination: destination,
            owner: owner,
            amount: amount,
            decimals: decimals,
          )
        ],
      );

  factory TokenProgram.approve({
    required int amount,
    required String source,
    required String delegate,
    required String sourceOwner,
    List<String> signers = const <String>[],
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.approve(
            amount: amount,
            source: source,
            delegate: delegate,
            sourceOwner: sourceOwner,
            signers: signers,
          )
        ],
      );

  factory TokenProgram.approveChecked({
    required int amount,
    required int decimals,
    required String source,
    required String mint,
    required String delegate,
    required String sourceOwner,
    List<String> signers = const <String>[],
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.approveChecked(
            amount: amount,
            decimals: decimals,
            source: source,
            mint: mint,
            delegate: delegate,
            sourceOwner: sourceOwner,
            signers: signers,
          )
        ],
      );

  factory TokenProgram.burn({
    required int amount,
    required String accountToBurnFrom,
    required String mint,
    required String owner,
    List<String> signers = const <String>[],
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.burn(
            amount: amount,
            signers: signers,
            mint: mint,
            accountToBurnFrom: accountToBurnFrom,
            owner: owner,
          )
        ],
      );

  factory TokenProgram.burnChecked({
    required int amount,
    required int decimals,
    required String accountToBurnFrom,
    required String mint,
    required String owner,
    List<String> signers = const <String>[],
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.burnChecked(
            amount: amount,
            decimals: decimals,
            signers: signers,
            mint: mint,
            accountToBurnFrom: accountToBurnFrom,
            owner: owner,
          )
        ],
      );

  factory TokenProgram.freezeAccount({
    required String accountToFreeze,
    required String mint,
    required String freezeAuthority,
    List<String> signers = const <String>[],
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.freezeAccount(
            accountToFreeze: accountToFreeze,
            mint: mint,
            freezeAuthority: freezeAuthority,
            signers: signers,
          ),
        ],
      );

  factory TokenProgram.thawAccount({
    required String accountToFreeze,
    required String mint,
    required String freezeAuthority,
    List<String> signers = const <String>[],
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.thawAccount(
            accountToFreeze: accountToFreeze,
            mint: mint,
            freezeAuthority: freezeAuthority,
            signers: signers,
          ),
        ],
      );

  factory TokenProgram.setAuthority({
    required String mintOrAccount,
    required String currentAuthority,
    required AuthorityType authorityType,
    required String newAuthority,
    List<String> signers = const <String>[],
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.setAuthority(
            mintOrAccount: mintOrAccount,
            currentAuthority: currentAuthority,
            authorityType: authorityType,
            newAuthority: newAuthority,
            signers: signers,
          ),
        ],
      );

  factory TokenProgram.revoke({
    required String source,
    required String sourceOwner,
  }) =>
      TokenProgram._(instructions: [
        TokenInstruction.revoke(
          source: source,
          sourceOwner: sourceOwner,
        ),
      ]);

  static const programId = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';

  // Instruction indexes
  static const initializeMintInstructionIndex = [0];
  static const initializeAccountInstructionIndex = [1];
  static const initializeMultisigInstructionIndex = [2];
  static const transferInstructionIndex = [3];
  static const approveInstructionIndex = [4];
  static const revokeInstructionIndex = [5];
  static const setAuthorityInstructionIndex = [6];
  static const mintToInstructionIndex = [7];
  static const burnInstructionIndex = [8];
  static const closeAccountInstructionIndex = [9];
  static const freezeAccountInstructionIndex = [10];
  static const thawAccountInstructionIndex = [11];
  static const transferCheckedInstructionIndex = [12];
  static const approveCheckedInstructionIndex = [13];
  static const mintToCheckedInstructionIndex = [14];
  static const burnCheckedInstructionIndex = [15];
  static const initializeAccount2InstructionIndex = [16];
  static const syncNativeInstructionIndex = [17];
  static const initializeAccount3InstructionIndex = [18];
  static const initializeMultisig2InstructionIndex = [19];
  static const initializeMint2InstructionIndex = [20];

  // This is computed by adding the bytes in the following
  // structure
  //
  // mintAuthorityOption:   int32 ( 4 bytes)
  // mintAuthority:        PubKey (32 bytes)
  // supply:                int64 ( 8 bytes)
  // decimals:               byte ( 1 bytes)
  // isInitialized:          byte ( 1 bytes)
  // freezeAuthorityOption: int32 ( 4 bytes)
  // freezeAuthority:      PubKey (32 bytes)
  static const neededMintAccountSpace = 82;

  // This is computed by adding the bytes in the following
  // structure
  //
  // mint:                 PubKey (32 bytes)
  // owner:                PubKey (32 bytes)
  // amount:               uint64 ( 8 bytes)
  // delegateOption:       uint32 ( 4 bytes)
  // delegate:             PubKey (32 bytes)
  // state:                byte   ( 1 bytes)
  // isNativeOption:       uint32 ( 4 bytes)
  // isNative:             uint64 ( 8 bytes)
  // delegatedAmount:      uint64 ( 8 bytes)
  // closeAuthorityOption: uint32 ( 4 bytes)
  // closeAuthority:       PubKey (32 bytes)
  static const neededAccountSpace = 165;
}

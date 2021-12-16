import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/programs/system_program/system_instruction.dart';

export 'package:solana/src/programs/system_program/system_instruction.dart';

class SystemProgram extends Message {
  const SystemProgram._({
    required List<Instruction> instructions,
  }) : super(instructions: instructions);

  /// Create account.
  ///
  /// Create a program account for [owner] owned by [fromPubKey] and with
  /// [pubKey] public key.
  ///
  /// For the [rent] you must call [RPCClient.getMinimumBalanceForRentExemption()]
  /// and provide the [space] you want to allocate for the account.
  ///
  /// The account will be linked to the [owner] program.
  ///
  /// If [pubKey] is the [fromPubKey]'s address, and the owner has tokens this will
  /// fail because the account would already exist.
  factory SystemProgram.createAccount({
    required String pubKey,
    required String fromPubKey,
    required int lamports,
    required int space,
    required String owner,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.createAccount(
            pubKey: pubKey,
            fromPubKey: fromPubKey,
            lamports: lamports,
            space: space,
            owner: owner,
          ),
        ],
      );

  /// Assign [pubKey] to [owner]
  factory SystemProgram.assign({
    required String pubKey,
    required String owner,
  }) =>
      SystemProgram._(instructions: [
        SystemInstruction.assign(pubKey: pubKey, owner: owner),
      ]);

  /// Transfer [lamports] SOL tokens from [source] to [destination].
  factory SystemProgram.transfer({
    required String source,
    required String destination,
    required int lamports,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.transfer(
            source: source,
            destination: destination,
            lamports: lamports,
          )
        ],
      );

  factory SystemProgram.createAccountWithSeed({
    required String fromPubKey,
    required String pubKey,
    required String? base,
    required String seed,
    required int lamports,
    required int space,
    required String owner,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.createAccountWithSeed(
            fromPubKey: fromPubKey,
            pubKey: pubKey,
            base: base,
            seed: seed,
            lamports: lamports,
            space: space,
            owner: owner,
          )
        ],
      );

  factory SystemProgram.advanceNonceAccount({
    required String noncePubKey,
    required String authorizedPubKey,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.advanceNonceAccount(
            noncePubKey: noncePubKey,
            authorizedPubKey: authorizedPubKey,
          )
        ],
      );

  factory SystemProgram.withdrawNonceAccount({
    required String noncePubKey,
    required String authorizedPubKey,
    required String toPubKey,
    required int lamports,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.withdrawNonceAccount(
            noncePubKey: noncePubKey,
            authorizedPubKey: authorizedPubKey,
            toPubKey: toPubKey,
            lamports: lamports,
          )
        ],
      );

  factory SystemProgram.createNonceAccount({
    required String fromPubKey,
    required String noncePubKey,
    required String authority,
    required int lamports,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.createAccount(
            fromPubKey: fromPubKey,
            pubKey: noncePubKey,
            lamports: lamports,
            space: nonceAccountSize,
            owner: SystemProgram.programId,
          ),
          SystemInstruction.initializeNonceAccount(
            noncePubKey: noncePubKey,
            authority: authority,
          )
        ],
      );

  factory SystemProgram.createNonceAccountWithSeed({
    required String fromPubKey,
    required String noncePubKey,
    required String base,
    required String seed,
    required String authority,
    required int lamports,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.createAccountWithSeed(
            fromPubKey: fromPubKey,
            pubKey: noncePubKey,
            lamports: lamports,
            space: nonceAccountSize,
            seed: seed,
            base: base,
            owner: SystemProgram.programId,
          ),
          SystemInstruction.initializeNonceAccount(
            noncePubKey: noncePubKey,
            authority: authority,
          )
        ],
      );

  factory SystemProgram.authorizeNonceAccount({
    required String noncePubKey,
    required String authorizedPubKey,
    required String newAuthority,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.authorizeNonceAccount(
            noncePubKey: noncePubKey,
            authorizedPubKey: authorizedPubKey,
            newAuthority: newAuthority,
          )
        ],
      );

  factory SystemProgram.allocate({
    required String pubKey,
    required int space,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.allocate(pubKey: pubKey, space: space),
        ],
      );

  factory SystemProgram.allocateWithSeed({
    required String pubKey,
    required int space,
    required String base,
    required String seed,
    required String owner,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.allocateWithSeed(
            pubKey: pubKey,
            base: base,
            seed: seed,
            space: space,
            owner: owner,
          )
        ],
      );

  factory SystemProgram.assignWithSeed({
    required String pubKey,
    required String base,
    required String seed,
    required String owner,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.assignWithSeed(
            pubKey: pubKey,
            base: base,
            seed: seed,
            owner: owner,
          )
        ],
      );

  factory SystemProgram.transferWithSeed({
    required String source,
    required String base,
    required String seed,
    required String destination,
    required int lamports,
    required String owner,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.transferWithSeed(
            source: source,
            base: base,
            seed: seed,
            owner: owner,
            destination: destination,
            lamports: lamports,
          )
        ],
      );

  static const programId = '11111111111111111111111111111111';

  static const createAccountInstructionIndex = [0, 0, 0, 0];
  static const assignInstructionIndex = [1, 0, 0, 0];
  static const transferInstructionIndex = [2, 0, 0, 0];
  static const createAccountWithSeedInstructionIndex = [3, 0, 0, 0];
  static const advanceNonceAccountInstructionIndex = [4, 0, 0, 0];
  static const withdrawNonceAccountInstructionIndex = [5, 0, 0, 0];
  static const initializeNonceAccountInstructionIndex = [6, 0, 0, 0];
  static const authorizeNonceAccountInstructionIndex = [7, 0, 0, 0];
  static const allocateInstructionIndex = [8, 0, 0, 0];
  static const allocateWithSeedInstructionIndex = [9, 0, 0, 0];
  static const assignWithSeedInstructionIndex = [10, 0, 0, 0];
  static const transferWithSeedInstructionIndex = [11, 0, 0, 0];

  // Note: in the rust sdk this is computed dynamically.
  //
  // Currently the object has 3 fields
  //
  // - Authority (PubKey) 32 bytes
  // - Blockhash 40 bytes
  // - FeeCalculator (lamportsPerSol int64) (8 bytes)
  static const nonceAccountSize = 80;
}

import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
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
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey fromPubKey,
    required int lamports,
    required int space,
    required Ed25519HDPublicKey owner,
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
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey owner,
  }) =>
      SystemProgram._(instructions: [
        SystemInstruction.assign(pubKey: pubKey, owner: owner),
      ]);

  /// Transfer [lamports] SOL tokens from [source] to [destination].
  factory SystemProgram.transfer({
    required Ed25519HDPublicKey source,
    required Ed25519HDPublicKey destination,
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
    required Ed25519HDPublicKey fromPubKey,
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey base,
    required String seed,
    required int lamports,
    required int space,
    required Ed25519HDPublicKey owner,
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
    required Ed25519HDPublicKey nonceAuthorityPubKey,
    required Ed25519HDPublicKey authorizedPubKey,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.advanceNonceAccount(
            noncePubKey: nonceAuthorityPubKey,
            nonceAuthorityPubKey: authorizedPubKey,
          )
        ],
      );

  factory SystemProgram.withdrawNonceAccount({
    required Ed25519HDPublicKey noncePubKey,
    required Ed25519HDPublicKey authorizedPubKey,
    required Ed25519HDPublicKey toPubKey,
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
    required Ed25519HDPublicKey fromPubKey,
    required Ed25519HDPublicKey noncePubKey,
    required Ed25519HDPublicKey noceAuthorityPubKey,
    required int lamports,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.createAccount(
            fromPubKey: fromPubKey,
            pubKey: noncePubKey,
            lamports: lamports,
            space: nonceAccountSize,
            owner: Ed25519HDPublicKey.fromBase58(SystemProgram.programId),
          ),
          SystemInstruction.initializeNonceAccount(
            noncePubKey: noncePubKey,
            authority: noceAuthorityPubKey,
          )
        ],
      );

  factory SystemProgram.createNonceAccountWithSeed({
    required Ed25519HDPublicKey fromPubKey,
    required Ed25519HDPublicKey noncePubKey,
    required Ed25519HDPublicKey base,
    required String seed,
    required Ed25519HDPublicKey authority,
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
            owner: Ed25519HDPublicKey.fromBase58(SystemProgram.programId),
          ),
          SystemInstruction.initializeNonceAccount(
            noncePubKey: noncePubKey,
            authority: authority,
          )
        ],
      );

  factory SystemProgram.authorizeNonceAccount({
    required Ed25519HDPublicKey noncePubKey,
    required Ed25519HDPublicKey authorizedPubKey,
    required Ed25519HDPublicKey newAuthority,
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
    required Ed25519HDPublicKey pubKey,
    required int space,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.allocate(pubKey: pubKey, space: space),
        ],
      );

  factory SystemProgram.allocateWithSeed({
    required Ed25519HDPublicKey pubKey,
    required int space,
    required Ed25519HDPublicKey base,
    required String seed,
    required Ed25519HDPublicKey owner,
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
    required Ed25519HDPublicKey pubKey,
    required Ed25519HDPublicKey base,
    required String seed,
    required Ed25519HDPublicKey owner,
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
    required Ed25519HDPublicKey source,
    required Ed25519HDPublicKey base,
    required String seed,
    required Ed25519HDPublicKey destination,
    required int lamports,
    required Ed25519HDPublicKey owner,
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
  // - Blockhash (32 + 8) bytes
  // - FeeCalculator (lamportsPerSol int64) (8 bytes)
  static const nonceAccountSize = 80;
}

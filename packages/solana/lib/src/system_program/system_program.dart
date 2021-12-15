import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/system_program/system_instruction.dart';

export 'package:solana/src/system_program/system_instruction.dart';

class SystemProgram extends Message {
  const SystemProgram._({
    required List<Instruction> instructions,
  }) : super(instructions: instructions);

  /// Create account.
  ///
  /// Create a program account for [owner] owned by [creator] and with
  /// [pubKey] public key.
  ///
  /// For the [rent] you must call [RPCClient.getMinimumBalanceForRentExemption()]
  /// and provide the [space] you want to allocate for the account.
  ///
  /// The account will be linked to the [owner] program.
  ///
  /// If [pubKey] is the [creator]'s address, and the owner has tokens this will
  /// fail because the account would already exist.
  factory SystemProgram.createAccount({
    required String pubKey,
    required String creator,
    required int lamports,
    required int space,
    required String owner,
  }) =>
      SystemProgram._(
        instructions: [
          SystemInstruction.createAccount(
            address: pubKey,
            creator: creator,
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
}

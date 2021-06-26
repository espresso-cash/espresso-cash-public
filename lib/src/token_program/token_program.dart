library token_program;

import 'package:solana/src/associated_token_account_program/associated_token_account_program.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/system_program/system_program.dart';

part 'token_instruction.dart';

class TokenProgram extends Message {
  TokenProgram._({
    required List<Instruction> instructions,
  }) : super(
          instructions: instructions,
        );

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
            address: address,
            owner: owner,
          ),
        ],
      );

  factory TokenProgram.mintTo({
    required String mint,
    required String destination,
    required String owner,
    required int amount,
    String? feePayer,
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.mintTo(
            mint: mint,
            destination: destination,
            owner: owner,
            amount: amount,
            feePayer: feePayer,
          ),
        ],
      );

  factory TokenProgram.transfer({
    required String source,
    required String destination,
    required String owner,
    required int amount,
    String? feePayer,
  }) =>
      TokenProgram._(
        instructions: [
          TokenInstruction.transfer(
            source: source,
            destination: destination,
            owner: owner,
            amount: amount,
            feePayer: feePayer,
          )
        ],
      );

  factory TokenProgram.createAssociatedTokenAccount({
    required String mint,
    required String address,
    required String owner,
    required String funder,
  }) =>
      TokenProgram._(
        instructions: [
          AssociatedTokenAccountInstruction(
            funder: funder,
            owner: owner,
            address: address,
            mint: mint,
          ),
        ],
      );

  static const programId = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';

  // Instruction indexes
  static const initializeMintInstructionIndex = [0];
  static const initializeAccountInstructionIndex = [1];
  static const transferInstructionIndex = [3];
  static const mintToInstructionIndex = [7];

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
  // mint:                 PubKey (32 bytes),
  // owner:                PubKey (32 bytes),
  // amount:               uint64 ( 8 bytes),
  // delegateOption:       uint32 ( 4 bytes),
  // delegate:             PubKey (32 bytes),
  // state:                byte   ( 1 bytes),
  // isNativeOption:       uint32 ( 4 bytes),
  // isNative:             uint64 ( 8 bytes),
  // delegatedAmount:      uint64 ( 8 bytes),
  // closeAuthorityOption: uint32 ( 4 bytes),
  // closeAuthority:       PubKey (32 bytes),
  static const neededAccountSpace = 165;
}

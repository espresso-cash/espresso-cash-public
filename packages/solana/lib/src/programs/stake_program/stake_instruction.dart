import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/constants.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/stake_program/stake_program.dart';
import 'package:solana/src/programs/stake_program/state.dart';

class StakeInstruction extends Instruction {
  StakeInstruction._({
    required List<AccountMeta> accounts,
    required Buffer data,
  }) : super(
          programId: StakeProgram.programId,
          accounts: accounts,
          data: data,
        );

  factory StakeInstruction.initialize({
    required String stakePubKey,
    required Authorized authorized,
    Lockup lockup = const Lockup.zero(),
  }) =>
      StakeInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: stakePubKey, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          StakeProgram.initializeInstructionIndex,
          authorized.serialize(),
          lockup.serialize(),
        ]),
      );

  factory StakeInstruction.authorize() => throw UnimplementedError();

  factory StakeInstruction.delegateStake() => throw UnimplementedError();

  factory StakeInstruction.split() => throw UnimplementedError();

  factory StakeInstruction.withdraw() => throw UnimplementedError();

  factory StakeInstruction.deactivate() => throw UnimplementedError();

  factory StakeInstruction.setLockup() => throw UnimplementedError();

  factory StakeInstruction.merge() => throw UnimplementedError();

  factory StakeInstruction.authorizeWithSeed() => throw UnimplementedError();

  factory StakeInstruction.initializeChecked() => throw UnimplementedError();

  factory StakeInstruction.authorizeChecked() => throw UnimplementedError();

  factory StakeInstruction.authorizeCheckedWithSeed() =>
      throw UnimplementedError();

  factory StakeInstruction.setLockupChecked() => throw UnimplementedError();
}

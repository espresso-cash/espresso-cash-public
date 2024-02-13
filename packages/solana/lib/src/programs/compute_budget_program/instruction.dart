import 'package:solana/encoder.dart';
import 'package:solana/src/programs/compute_budget_program/program.dart';

class ComputeBudgetInstruction extends Instruction {
  ComputeBudgetInstruction({
    required super.data,
  }) : super(programId: ComputeBudgetProgram.id, accounts: []);

  factory ComputeBudgetInstruction.requestHeapFrame({required int bytes}) =>
      ComputeBudgetInstruction(
        data: ByteArray.merge([
          ComputeBudgetProgram.requestHeapFrameIndex,
          ByteArray.u32(bytes),
        ]),
      );

  factory ComputeBudgetInstruction.setComputeUnitLimit({required int units}) =>
      ComputeBudgetInstruction(
        data: ByteArray.merge([
          ComputeBudgetProgram.setComputeUnitLimitIndex,
          ByteArray.u32(units),
        ]),
      );

  factory ComputeBudgetInstruction.setComputeUnitPrice({
    required int microLamports,
  }) =>
      ComputeBudgetInstruction(
        data: ByteArray.merge([
          ComputeBudgetProgram.setComputeUnitPriceIndex,
          ByteArray.u64(microLamports),
        ]),
      );

  factory ComputeBudgetInstruction.setLoadedAccountsDataSizeLimit({
    required int bytes,
  }) =>
      ComputeBudgetInstruction(
        data: ByteArray.merge([
          ComputeBudgetProgram.setLoadedAccountsDataSizeLimitIndex,
          ByteArray.u32(bytes),
        ]),
      );
}

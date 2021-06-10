/*
class SystemInstruction extends Instruction {
  factory SystemInstruction(
      List<AccountMeta> accounts, CompactArray<int> data) {}
  SystemInstruction._({
    required int programIdIndex,
    required CompactArray<int> accountIndices,
    required CompactArray<int> data,
  }) : super(
          programIdIndex: programIdIndex,
          accountIndices: accountIndices,
          data: data,
        );

  factory SystemInstruction.transfer(int lamports) => SystemInstruction._(
        programIdIndex: 2,
        accountIndices: CompactArray.fromList([0, 1, 2]),
        data: CompactArray.fromList(
          [
            ...Int.from(2, bitSize: 32),
            ...Int.from(lamports, bitSize: 64),
          ],
        ),
      );

  factory SystemInstruction.autoTransfer(int lamports) => SystemInstruction._(
        programIdIndex: 1,
        accountIndices: CompactArray.fromList([0, 1]),
        data: CompactArray.fromList(
          [
            ...Int.from(2, bitSize: 32),
            ...Int.from(lamports, bitSize: 64),
          ],
        ),
      );
}
*/

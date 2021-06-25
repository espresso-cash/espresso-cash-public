part of 'encoder.dart';

/// Taken from [here](https://spl.solana.com/memo#compute-limits)
const _memoSizeLimit = 566;

/// An instruction representation that can be converted to a [CompiledInstruction]
/// and included into a message.
class Instruction {
  /// Construct a generic instruction for the [programId] program
  /// with [accounts]. These accounts will be interpreted by the
  /// specific program with id [programId].
  ///
  /// Some programs take specific [data]. You can provide raw 8bit bytes arrays
  /// with the [data] parameter.
  const Instruction({
    required this.programId,
    required this.accounts,
    required this.data,
  }) : super();

  /// Construct a memo instruction for the memo program with
  /// [signers] as signers and [memo] as content.
  ///
  /// Please note that there's a limit on the length of the [memo] string, which
  /// otherwise is an arbitrary string of utf-8 data.
  ///
  /// The limit as [specified in this document][memo limit] is 566 bytes.
  ///
  /// [memo limit](https://spl.solana.com/memo#compute-limits)
  factory Instruction.memo({
    required List<AccountMeta> signers,
    required Buffer memo,
  }) {
    if (memo.length > _memoSizeLimit) {
      throw const FormatException(
        'the [memo] cannot be more than 566 bytes length',
      );
    }
    return Instruction(
      programId: MemoProgram.id,
      accounts: signers,
      data: memo,
    );
  }

  final String programId;
  final Iterable<AccountMeta> accounts;
  final ByteArray data;
}

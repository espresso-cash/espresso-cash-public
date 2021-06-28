part of 'encoder.dart';

/// Taken from [here](https://spl.solana.com/memo#compute-limits)
///
/// An instruction representation that can be converted to a [_CompiledInstruction]
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

  final String programId;
  final List<AccountMeta> accounts;
  final ByteArray data;
}

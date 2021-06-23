part of 'encoder.dart';

/// Convenience class with constructors for specific program
/// data that can be interpreted by a given program.
class InstructionData extends ByteArray {
  /// Build the program data for a transfer instruction with
  InstructionData.transfer({required int lamports})
      : _data = Buffer.fromConcatenatedByteArrays([
          SystemProgram.transfer,
          Buffer.fromInt64(lamports),
        ]);

  InstructionData.createAccount({
    required int rent,
    required int space,
    required String programId,
  }) : _data = Buffer.fromConcatenatedByteArrays([
          SystemProgram.createAccount,
          Buffer.fromUint64(rent),
          Buffer.fromUint64(space),
          Buffer.fromBase58(programId),
        ]);

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}

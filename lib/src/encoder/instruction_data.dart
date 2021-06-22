part of 'encoder.dart';

/// Convenience class with constructors for specific program
/// data that can be interpreted by a given program.
class InstructionData extends Iterable<int> {
  InstructionData(Iterable<Iterable<int>> data)
      : _data = Buffer.fromByteArrays(data);

  /// Build the program data for a transfer instruction with
  factory InstructionData.transfer({required int lamports}) => InstructionData([
        SystemProgram.transfer,
        Buffer.fromInt64(lamports),
      ]);

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}

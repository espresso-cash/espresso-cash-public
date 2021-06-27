part of 'encoder.dart';

/// Class to convert the [Instruction] representation of an instruction to
/// the [Instruction Format][instruction format].
///
/// [instruction format]: https://docs.solana.com/developing/programming-model/transactions#instruction-format
class _CompiledInstruction extends ByteArray {
  factory _CompiledInstruction({
    required Instruction instruction,
    required Map<String, int> accountIndexesMap,
  }) {
    final Iterable<AccountMeta> accounts = instruction.accounts;
    final data = _CompactArray.fromIterable(instruction.data);
    if (!accountIndexesMap.containsKey(instruction.programId)) {
      throw const FormatException('programId not found in accountIndexesMap');
    }
    final programIdIndex =
        Buffer.fromInt8(accountIndexesMap[instruction.programId]!);
    final accountIndexes = _CompactArray.fromIterable(
      accounts.map((a) {
        if (!accountIndexesMap.containsKey(a.pubKey)) {
          throw const FormatException(
            'one of the supplied accounts was not found in the accountIndexesMap',
          );
        }

        return accountIndexesMap[a.pubKey]!;
      }),
    );

    return _CompiledInstruction._(
      programIdIndex: programIdIndex,
      accountIndexes: accountIndexes,
      data: data,
    );
  }

  _CompiledInstruction._({
    required ByteArray programIdIndex,
    required ByteArray accountIndexes,
    required ByteArray data,
  }) : _data = Buffer.fromConcatenatedByteArrays([
          programIdIndex,
          accountIndexes,
          data,
        ]);

  final ByteArray _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}

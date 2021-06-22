part of 'encoder.dart';

/// Class to convert the [Instruction] representation of an instruction to
/// the [Instruction Format][instruction format].
///
/// [instruction format]: https://docs.solana.com/developing/programming-model/transactions#instruction-format
class CompiledInstruction extends Iterable<int> {
  factory CompiledInstruction({
    required Instruction instruction,
    required Iterable<AccountMeta> messageAccounts,
  }) {
    final Iterable<AccountMeta> accounts = instruction.accounts;
    final Map<String, int> accountsMap = messageAccounts.toIndexesMap();
    final data = CompactArray.fromIterable(instruction.data);
    if (!accountsMap.containsKey(instruction.programId)) {
      throw ArgumentError('programId not found in accountsMap');
    }
    final programIdIndex = Buffer.fromInt8(accountsMap[instruction.programId]!);
    final accountIndexes = CompactArray.fromIterable(
      accounts.map((a) {
        if (!accountsMap.containsKey(a.pubKey)) {
          throw ArgumentError(
            'one of the supplied accounts was not found in the accountsMap',
          );
        }

        return accountsMap[a.pubKey]!;
      }),
    );

    return CompiledInstruction._(
      programIdIndex: programIdIndex,
      accountIndexes: accountIndexes,
      data: data,
    );
  }

  CompiledInstruction._({
    required Iterable<int> programIdIndex,
    required Iterable<int> accountIndexes,
    required Iterable<int> data,
  }) : _data = Buffer.fromByteArrays([
          programIdIndex,
          accountIndexes,
          data,
        ]);

  final Iterable<int> _data;

  @override
  Iterator<int> get iterator => _data.iterator;
}

extension on Iterable<AccountMeta> {
  Map<String, int> toIndexesMap() {
    final Map<String, int> mapped = {};

    for (int i = 0; i < length; ++i) {
      final AccountMeta item = elementAt(i);
      mapped[item.pubKey] = i;
    }

    return mapped;
  }
}

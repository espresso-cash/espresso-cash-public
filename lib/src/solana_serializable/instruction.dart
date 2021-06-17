import 'package:solana/src/constants/constants.dart';
import 'package:solana/src/solana_serializable/int.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';
import 'package:solana/src/solana_serializable/string.dart';
import 'package:solana/src/types/account_meta.dart';

/// Taken from [here](https://spl.solana.com/memo#compute-limits)
const _memoSizeLimit = 566;

/// An implementation of the solana [Instruction Format][instruction format]
///
/// [instruction format]: https://docs.solana.com/developing/programming-model/transactions#instruction-format
class Instruction {
  /// Construct a generic instruction for the [programId] program
  /// with [accounts] being the same array that will be passed with
  /// the message carrying this instruction and [accounts] being any
  /// of those in accounts that will be used by the program itself.
  ///
  /// The [accounts] array will be used to build the array of indexes for
  /// this instruction.
  ///
  /// The [data] parameter can be used to pass the data to be interpreted
  /// by [programId] and is to be specified as raw bytes.
  Instruction({
    required this.programId,
    required this.accounts,
    required List<int> data,
  })  : _data = CompactArray.fromIterable(data),
        super();

  /// Create a system program instruction with [data], for [accounts].
  /// The [accounts] must be sorted according to the
  /// [Account Address Format][account address format]
  ///
  /// Use [keys] to provide the program specific keys. These [keys] are often
  /// required to be in a specific order. Like for instance in a transfer
  /// program they must be `[source, destination]`.
  ///
  /// [account address format]: https://docs.solana.com/developing/programming-model/transactions#account-addresses-format
  factory Instruction.system({
    required List<AccountMeta> accounts,
    required List<int> data,
  }) =>
      Instruction(
        programId: SystemProgram.id,
        accounts: accounts,
        data: data,
      );

  factory Instruction.memo({
    required List<AccountMeta> accounts,
    required SerializableString memo,
  }) {
    if (memo.size > _memoSizeLimit) {
      throw const FormatException(
        'the [memo] cannot be more than 566 bytes length',
      );
    }

    return Instruction(
      programId: MemoProgram.id,
      accounts: accounts,
      data: memo.serialize(),
    );
  }

  final String programId;
  final List<AccountMeta> accounts;
  final CompactArray<int> _data;

  List<int> compile(Iterable<AccountMeta> messageAccounts) {
    final programIdIndex = messageAccounts.indexOfPubKey(programId);
    if (programIdIndex == -1) {
      throw ArgumentError('accounts did not contain the program id');
    }
    final accountsIndexes = CompactArray.fromIterable(
      accounts.extractIndexesFromAccountMetas(messageAccounts),
    );
    return [
      ...SerializableInt.from(programIdIndex),
      ...accountsIndexes.serialize(),
      ..._data.serialize(),
    ];
  }
}

extension on Iterable<AccountMeta> {
  List<int> extractIndexesFromAccountMetas(Iterable<AccountMeta> accounts) =>
      map(
        (AccountMeta account) {
          final index = accounts.indexOfPubKey(account.pubKey);
          if (index == -1) {
            throw ArgumentError(
              "'${account.pubKey}' was not found in the list of accounts metadata",
            );
          }
          return index;
        },
      ).toList();
}

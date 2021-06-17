import 'package:solana/src/constants/constants.dart';
import 'package:solana/src/solana_serializable/compact_array.dart';
import 'package:solana/src/solana_serializable/int.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';
import 'package:solana/src/solana_serializable/string.dart';
import 'package:solana/src/types/account_meta.dart';

/// Taken from
/// https://spl.solana.com/memo#compute-limits
const _memoSizeLimit = 566;

class Instruction extends Serializable {
  Instruction({
    required String programId,
    required List<String> keys,
    required List<AccountMeta> accounts,
    required List<int> data,
  })  : _programIdIndex = accounts.indexOfPubKey(programId),
        _accountIndices = CompactArray.fromList(
          keys.extractIndexesFromAccountMetas(accounts),
        ),
        _data = CompactArray.fromList(data),
        super() {
    if (_programIdIndex == -1) {
      throw ArgumentError(
        'the program id must be present in the accounts array',
      );
    }
  }

  /// Create a system program instruction with [data] for [accounts].
  /// The [accounts] must be sorted according to
  ///
  /// https://docs.solana.com/developing/programming-model/transactions#account-addresses-format
  factory Instruction.system({
    required List<String> keys,
    required List<AccountMeta> accounts,
    required List<int> data,
  }) =>
      Instruction(
        programId: SystemProgram.id,
        keys: keys,
        accounts: accounts,
        data: data,
      );

  factory Instruction.memo({
    required List<String> keys,
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
      keys: keys,
      accounts: accounts,
      data: memo.serialize(),
    );
  }

  final int _programIdIndex;
  final CompactArray<int> _accountIndices;
  final CompactArray<int> _data;

  @override
  List<int> serialize() {
    final SerializableInt programIdIndex =
        SerializableInt.from(_programIdIndex);
    return [
      ...programIdIndex.serialize(),
      ..._accountIndices.serialize(),
      ..._data.serialize(),
    ];
  }
}

extension on Iterable<String> {
  List<int> extractIndexesFromAccountMetas(List<AccountMeta> metas) => map(
        (String pubKey) => metas.indexOfPubKey(pubKey),
      ).toList();
}

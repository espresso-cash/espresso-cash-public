import 'package:solana/src/constants/constants.dart';
import 'package:solana/src/solana_serializable/compact_array.dart';
import 'package:solana/src/solana_serializable/int.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';
import 'package:solana/src/solana_serializable/string.dart';
import 'package:solana/src/types/account_meta.dart';

class Instruction extends Serializable {
  Instruction._(
    this._programIdIndex,
    this._accountIndices,
    this._data,
  );

  /// Create a system program instruction with [data] for [accounts].
  /// The [accounts] must be sorted according to
  ///
  /// https://docs.solana.com/developing/programming-model/transactions#account-addresses-format
  factory Instruction.system({
    required List<AccountMeta> accounts,
    required List<String> pubKeys,
    required CompactArray<int> data,
  }) {
    final programIdIndex = accounts.indexOfPubKey(SystemProgram.id);
    return Instruction._(
      programIdIndex,
      CompactArray.fromList(
        pubKeys.extractIndexesFromAccountMetas(accounts),
      ),
      data,
    );
  }

  factory Instruction.memo({
    required List<AccountMeta> accounts,
    required List<String> signers,
    required SerializableString memo,
  }) {
    final programIdIndex = accounts.indexOfPubKey(MemoProgram.id);
    return Instruction._(
      programIdIndex,
      CompactArray<int>.fromList(
        signers.extractIndexesFromAccountMetas(accounts),
      ),
      CompactArray<int>.fromList(memo.serialize()),
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

extension on List<String> {
  List<int> extractIndexesFromAccountMetas(List<AccountMeta> metas) => map(
        (String pubKey) => metas.indexOfPubKey(pubKey),
      ).toList();
}

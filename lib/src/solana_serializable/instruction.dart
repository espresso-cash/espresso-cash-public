import 'package:solana/solana.dart';
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

  /// Create a system program instruction with [data] for [metas].
  /// The [metas] must be sorted according to
  ///
  /// https://docs.solana.com/developing/programming-model/transactions#account-addresses-format
  factory Instruction.system({
    required List<AccountMeta> metas,
    required List<String> pubKeys,
    required CompactArray<int> data,
  }) {
    final programIdIndex = metas.indexWhere(
      (meta) => meta.pubKey == systemProgramID,
    );
    return Instruction._(
      programIdIndex,
      CompactArray.fromList(
        pubKeys.extractIndexes(metas),
      ),
      data,
    );
  }

  factory Instruction.memo({
    required List<AccountMeta> metas,
    required List<String> signers,
    required Str memo,
  }) {
    final programIdIndex = metas.indexWhere(
      (meta) => meta.pubKey == memoProgramID,
    );
    return Instruction._(
      programIdIndex,
      CompactArray<int>.fromList(signers.extractIndexes(metas)),
      CompactArray<int>.fromList(memo.serialize()),
    );
  }

  final int _programIdIndex;
  final CompactArray<int> _accountIndices;
  final CompactArray<int> _data;

  @override
  List<int> serialize() {
    final Int programIdIndex = Int.from(_programIdIndex);
    return [
      ...programIdIndex.serialize(),
      ..._accountIndices.serialize(),
      ..._data.serialize(),
    ];
  }
}

extension on List<String> {
  List<int> extractIndexes(List<AccountMeta> metas) => map(
        (String each) => metas.indexWhere((meta) => meta.pubKey == each),
      ).toList();
}

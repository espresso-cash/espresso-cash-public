import 'package:crypto_please_solana_lib/src/types/compact_array.dart';
import 'package:crypto_please_solana_lib/src/types/serializable.dart';
import 'package:crypto_please_solana_lib/src/types/serializable_int.dart';
import 'package:meta/meta.dart';

class Instruction extends Serializable {
  Instruction({
    @required this.programIdIndex,
    @required this.accountIndices,
    @required this.data,
  });

  final int programIdIndex;
  final CompactArray<int> accountIndices;
  final CompactArray<int> data;

  @override
  List<int> serialize() {
    final SerializableInt serializableProgramIdIndex =
        SerializableInt.from(programIdIndex);
    return [
      ...serializableProgramIdIndex.serialize(),
      ...accountIndices.serialize(),
      ...data.serialize(),
    ];
  }
}

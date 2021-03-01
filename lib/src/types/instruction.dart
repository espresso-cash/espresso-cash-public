import 'package:meta/meta.dart';
import 'package:solana_dart/src/types/compact_array.dart';
import 'package:solana_dart/src/types/serializable.dart';
import 'package:solana_dart/src/types/serializable_int.dart';

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

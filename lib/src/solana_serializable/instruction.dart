import 'package:meta/meta.dart';
import 'package:solana_dart/src/solana_serializable/compact_array.dart';
import 'package:solana_dart/src/solana_serializable/serializable.dart';
import 'package:solana_dart/src/solana_serializable/serializable_int.dart';

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

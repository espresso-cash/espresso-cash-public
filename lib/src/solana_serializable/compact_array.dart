import 'package:solana/src/solana_serializable/compact_u16.dart';
import 'package:solana/src/solana_serializable/int.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';

class CompactArray<T> extends Serializable {
  const CompactArray.fromList(this._items);

  final List<T> _items;

  @override
  List<int> serialize() {
    final List<int> Function(T) serializeItem = (T value) {
      if (value is Serializable) {
        return value.serialize();
      } else if (value is int) {
        return SerializableInt.from(value);
      } else {
        throw FormatException('cannot serialize $value');
      }
    };
    final reducer = (List<int> values, List<int> next) => [...values, ...next];
    final mapped = List<List<int>>.from(_items.map<List<int>>(serializeItem));
    final length = CompactU16(mapped.length);
    final mappedAndReduced = mapped.reduce(reducer);
    if (mapped.isEmpty) {
      return length.serialize();
    }
    return [...length.serialize(), ...mappedAndReduced];
  }
}

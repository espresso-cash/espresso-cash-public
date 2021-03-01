import 'package:crypto_please_solana_lib/src/types/compact_u16.dart';
import 'package:crypto_please_solana_lib/src/types/serializable.dart';
import 'package:crypto_please_solana_lib/src/util/encode_int.dart';

class CompactArray<T> extends Serializable {
  CompactArray.fromList(this._items);
  final List<T> _items;

  @override
  List<int> serialize() {
    List<int> Function(T) serializeItem = (T value) {
      if (value is Serializable) {
        return value.serialize();
      } else if (T == int) {
        return encodeInt(value as int);
      } else {
        return [];
      }
    };
    var reducer = (List<int> values, List<int> next) => [...values, ...next];
    var mapped = List<List<int>>.from(_items.map(serializeItem));
    Compact_u16 length = Compact_u16(mapped.length);
    List<int> mappedAndReduced = mapped.reduce(reducer);
    if (mapped.length == 0) {
      return length.serialize();
    }
    return [...length.serialize(), ...mappedAndReduced];
  }
}

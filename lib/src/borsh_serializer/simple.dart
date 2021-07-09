import 'package:solana/src/borsh_serializer/borsh_serializer.dart';

List<int> serializeMap(Map<String, dynamic> map) => map.toBorshBytes();

bool _isGrowable(List list) {
  try {
    list
      ..add(list[0])
      ..removeAt(list.length - 1);
    return true;
  } on Exception {
    return false;
  }
}

extension on Map<String, dynamic> {
  List<int> toBorshBytes() {
    final List<int> data = [];
    for (final entry in entries) {
      final dynamic value = entry.value;
      if (value is String) {
        final bytes = value.codeUnits;
        final length = BorshInteger.u32(bytes.length);
        data..addAll(length.serialize())..addAll(bytes);
      } else if (value is BorshSerializable) {
        data.addAll(value.serialize());
      } else if (value is List) {
        final length = BorshInteger.u32(value.length);
        if (_isGrowable(value)) {
          data.addAll(length.serialize());
        }
        for (final item in value) {
          if (item is! BorshSerializable) {
            throw ArgumentError('array items must be serializable');
          }
          data.addAll(item.serialize());
        }
      } else {
        throw ArgumentError('unsupported type in map');
      }
    }
    // data.addAll('}'.codeUnits);
    return data;
  }
}

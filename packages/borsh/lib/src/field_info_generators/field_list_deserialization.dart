import 'package:borsh/src/extensions.dart';
import 'package:borsh/src/field_info_generators/utils.dart';
import 'package:borsh/src/generator_utils.dart';
import 'package:borsh/src/type.dart';

String generateDeserializationCode(List<FieldInfo> fields) {
  final StringBuffer buffer = StringBuffer();
  for (final field in fields) {
    late final String value;
    late final String size;
    final name = field.name;
    final itemType = field.itemType;
    final type = field.type;
    final length = field.length;
    switch (type) {
      case Borsh.u8:
      case Borsh.i8:
      case Borsh.u16:
      case Borsh.i16:
      case Borsh.u32:
      case Borsh.i32:
      case Borsh.u64:
      case Borsh.i64:
        value = '_view.readInteger(${field.type}, offset)';
        size = '${type.size}';
        break;
      case Borsh.string:
        value = '_view.readString(offset)';
        size = '4 + $name.length';
        break;
      case Borsh.array:
        value = _generateArrayReaderCode(itemType, length, 'Fixed');
        size = '${generateArraySizeCalculatorCode(field)}';
        break;
      case Borsh.dynamicArray:
        value = _generateArrayReaderCode(itemType, length, 'Dynamic');
        size = '4 + ${generateArraySizeCalculatorCode(field)}';
        break;
      case Borsh.struct:
        throw UnimplementedError();
      case Borsh.invalid:
        throw ArgumentError("cannot deserialize field of 'invalid' type");
    }
    buffer.write('final $name = $value;\noffset += $size;\n\n');
  }
  return buffer.toString();
}

String _generateArrayReaderCode(
  Borsh? itemType,
  int? length,
  String fixedOrDynamic,
) {
  if (fixedOrDynamic != 'Fixed' && fixedOrDynamic != 'Dynamic') {
    throw ArgumentError(
      'can only generate readers for "Fixed" or "Dynamic" arrays',
    );
  }
  if (fixedOrDynamic == 'Fixed' && length == null) {
    throw ArgumentError(
      'instructed to read a fixed length array but the length is not available',
    );
  }
  if (itemType == null) {
    throw ArgumentError('item type cannot be null');
  }
  if (fixedOrDynamic == 'Fixed') {
    return '_view.readFixedArray<${itemType.native}>($itemType, $length, offset)';
  } else {
    return '_view.readDynamicArray<${itemType.native}>($itemType, offset)';
  }
}

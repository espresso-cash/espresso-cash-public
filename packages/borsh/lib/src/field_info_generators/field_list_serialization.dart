import 'package:borsh/src/extensions.dart';
import 'package:borsh/src/generator_utils.dart';
import 'package:borsh/src/type.dart';

String generateSerializationCode(List<FieldInfo> fields) {
  final StringBuffer buffer = StringBuffer();
  for (final field in fields) {
    final name = field.name;
    final itemType = field.itemType;
    switch (field.type) {
      case Borsh.u8:
      case Borsh.u16:
      case Borsh.u32:
      case Borsh.u64:
      case Borsh.i8:
      case Borsh.i16:
      case Borsh.i32:
      case Borsh.i64:
        buffer.write(
          'offset += data.writeInteger(${field.type}, offset, s.$name);',
        );
        break;
      case Borsh.string:
        buffer.write('offset += data.writeString(offset, s.$name);');
        break;
      case Borsh.dynamicArray:
        buffer.write(
          'offset += ${_generateArrayWriterCode(itemType, 'Dynamic', name)};',
        );
        break;
      case Borsh.array:
        buffer.write(
          'offset += ${_generateArrayWriterCode(itemType, 'Fixed', name)};',
        );
        break;
      case Borsh.struct:
        throw UnimplementedError();
      case Borsh.invalid:
        throw ArgumentError(
            'cannot generate serialization code for invalid type');
    }
  }
  return buffer.toString();
}

String _generateArrayWriterCode(
  Borsh? itemType,
  String fixedOrDynamic,
  String name,
) {
  if (fixedOrDynamic != 'Fixed' && fixedOrDynamic != 'Dynamic') {
    throw ArgumentError(
      'can only generate readers for "Fixed" or "Dynamic" arrays',
    );
  }
  if (itemType == null) {
    throw ArgumentError('item type cannot be null');
  }
  return 'data.write${fixedOrDynamic}Array<${itemType.native}>($itemType, offset, s.$name)';
}

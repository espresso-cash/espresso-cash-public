import 'package:borsh/src/extensions.dart';
import 'package:borsh/src/field_info_generators/utils.dart';
import 'package:borsh/src/generator_utils.dart';
import 'package:borsh/src/type.dart';

String generateSizeComputationCode(List<FieldInfo> fields) {
  final StringBuffer buffer = StringBuffer();
  int fixedSize = 0;
  for (final field in fields) {
    final type = field.type;
    final name = field.name;
    switch (type) {
      case Borsh.i8:
      case Borsh.u8:
      case Borsh.i16:
      case Borsh.u16:
      case Borsh.i32:
      case Borsh.u32:
      case Borsh.i64:
      case Borsh.u64:
        fixedSize += type.size;
        break;
      case Borsh.string:
        fixedSize += 4;
        buffer.write('size += s.$name.length;');
        break;
      case Borsh.dynamicArray:
        fixedSize += 4;
        buffer.write('size += s.${generateArraySizeCalculatorCode(field)};');
        break;
      case Borsh.array:
        buffer.write('size += s.${generateArraySizeCalculatorCode(field)};');
        break;
      case Borsh.struct:
        // TODO(iharob): this must be implemented too
        throw UnimplementedError();
      case Borsh.invalid:
        throw ArgumentError("cannot serialize field of 'invalid' type");
    }
  }
  buffer.write('size += $fixedSize;\n\n');
  return buffer.toString();
}

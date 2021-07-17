import 'package:borsh/src/extensions.dart';
import 'package:borsh/src/generator_utils.dart';
import 'package:borsh/src/type.dart';

String generateArraySizeCalculatorCode(FieldInfo fieldInfo) {
  final itemType = fieldInfo.itemType;
  final name = fieldInfo.name;
  if (itemType == null) {
    throw ArgumentError('item type cannot be null');
  }
  if (itemType.isPrimitive) {
    return '$name.length * ${itemType.size}';
  } else {
    if (itemType == Borsh.string || itemType == Borsh.dynamicArray) {
      return '$name.fold(0, (t, i) => t + i.length + 4)';
    } else if (itemType == Borsh.array) {
      return '$name.fold(0, (t, i) => t + i.length)';
    } else {
      throw UnimplementedError();
    }
  }
}

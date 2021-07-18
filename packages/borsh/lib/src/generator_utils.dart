import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:borsh/src/extensions.dart';
import 'package:borsh/src/type.dart';

FieldInfo? _constantValueToFieldInfo(
  String fieldName,
  DartObject constantValue,
) {
  final type = constantValue.type;
  if (type.toString() == '_Field') {
    final fieldType = constantValue.getFieldAs<Borsh>('type');
    if (fieldType == null) {
      throw ArgumentError('cannot determine field type');
    }

    // TODO(iharob): compare field type with borsh type to see if it's compatible
    return FieldInfo(name: fieldName, type: fieldType);
  } else if (type.toString() == 'Array') {
    final itemType = constantValue.getFieldAs<Borsh>('itemType');
    if (itemType == null) {
      throw ArgumentError('arrays must specify item types');
    }
    final fieldType = constantValue.getFieldAs<Borsh>('type');
    if (fieldType == null) {
      throw ArgumentError(
        'cannot determine if this is a dynamic or fixed length array',
      );
    }
    final length = constantValue.getFieldAs<int>('length');

    return FieldInfo(
      name: fieldName,
      type: fieldType,
      itemType: itemType,
      length: length,
    );
  } else {
    return null;
  }
}

DartObject? _toConstantValue(ElementAnnotation item) =>
    item.computeConstantValue();

FieldInfo? _getFieldInfo(FieldElement element) {
  final metadata = element.metadata;
  if (element.isPrivate) {
    return null;
  }

  final constantValues = metadata.map(_toConstantValue);
  if (constantValues.isEmpty) {
    return null;
  } else if (constantValues.length == 1) {
    final first = constantValues.first;
    if (first == null) {
      return null;
    }

    return _constantValueToFieldInfo(element.name, first);
  } else {
    throw ArgumentError('cannot extract field info');
  }
}

List<FieldInfo> classFieldToFieldInfos(List<FieldElement> classFields) {
  final List<FieldInfo> fields = [];
  for (final fieldElement in classFields) {
    final fieldInfo = _getFieldInfo(fieldElement);
    if (fieldInfo != null) {
      fields.add(fieldInfo);
    }
  }

  // For now, we don't sort the fields. We need to make sure that they
  // actually preserve the sorting order of their declarations.
  return fields;
}

class FieldInfo {
  const FieldInfo({
    required this.name,
    required this.type,
    this.length,
    this.itemType,
  });

  final Borsh type;
  final String name;

  final int? length;
  final Borsh? itemType;
}

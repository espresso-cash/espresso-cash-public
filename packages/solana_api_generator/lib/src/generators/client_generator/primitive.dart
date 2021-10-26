enum _PrimitiveType { list, map, pod, notPrimitive }

class Primitive {
  const Primitive._(
    this.valueType,
    this.keyType,
    this.type,
  );

  factory Primitive.pod(String declaration) =>
      Primitive._(declaration, '', _PrimitiveType.pod);

  factory Primitive.notPrimitive(String declaration) =>
      Primitive._(declaration, '', _PrimitiveType.notPrimitive);

  factory Primitive.list(String declaration) {
    final regexp = RegExp(r'List<\s*([^>]+)\s*>');
    final firstMatch = regexp.firstMatch(declaration);
    if (firstMatch == null) {
      throw ArgumentError('expected a list type declaration: $declaration');
    }

    final elementType = firstMatch.group(1);
    if (elementType == null) {
      throw ArgumentError('cannot determine list element type');
    }

    return Primitive._(elementType, '', _PrimitiveType.list);
  }

  factory Primitive.map(String declaration) {
    final regexp = RegExp(r'Map<\s*([^,]+)\s*,\s*(.+)\s*>');
    final firstMatch = regexp.firstMatch(declaration);
    if (firstMatch == null) {
      throw ArgumentError('expected a map type declaration got: $declaration');
    }

    final keyType = firstMatch.group(1);
    if (keyType == null) {
      throw ArgumentError('cannot determine list element type');
    }

    final elementType = firstMatch.group(2);
    if (elementType == null) {
      throw ArgumentError('cannot determine list element type');
    }

    return Primitive._(elementType, keyType, _PrimitiveType.map);
  }

  factory Primitive.fromTypeName(String typeName) {
    if (typeName.startsWith('List<')) {
      return Primitive.list(typeName);
    } else if (typeName.startsWith('Map<')) {
      return Primitive.map(typeName);
    } else if (typeName == 'int' || typeName == 'String') {
      return Primitive.pod(typeName);
    } else {
      return Primitive.notPrimitive(typeName);
    }
  }

  String toCode({
    required String extractor,
    required String variableName,
    bool nullable = false,
  }) {
    final optionalMarker = nullable ? '?' : '';
    final primitive = Primitive.fromTypeName(valueType);
    late final String convertValue;
    switch (primitive.type) {
      case _PrimitiveType.pod:
        convertValue = 'item as $valueType';
        break;
      case _PrimitiveType.notPrimitive:
        convertValue =
            '${primitive.valueType}.fromJson(item as Map<String, dynamic>)';
        break;
      default:
        convertValue = primitive.toCode(
          extractor: '',
          variableName: 'value',
          nullable: false,
        );
    }

    switch (type) {
      case _PrimitiveType.list:
        return '''
          _convertList(
            ${extractor == '' ? variableName : '$extractor($variableName)'}, 
            (dynamic item) => $convertValue,
          )
        ''';
      case _PrimitiveType.map:
        return '''
          _convertMap(
            ${extractor == '' ? variableName : '$extractor($variableName)'}, 
            (dynamic key) => key as String,
            (dynamic value) => $convertValue,
          )
        ''';
      case _PrimitiveType.pod:
        return '''
          ${extractor == '' ? variableName : '$extractor($variableName)'} as $valueType$optionalMarker
        ''';
      case _PrimitiveType.notPrimitive:
        throw UnsupportedError(
            'cannot create primitive code for non primitive');
    }
  }

  final String valueType;
  final String keyType;
  final _PrimitiveType type;
}

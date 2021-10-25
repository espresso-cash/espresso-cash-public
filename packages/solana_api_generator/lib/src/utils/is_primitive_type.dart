bool isPrimitiveType(String parsedType) =>
    parsedType == 'int' ||
    parsedType == 'String' ||
    parsedType.startsWith('List<') ||
    parsedType.startsWith('Map<');

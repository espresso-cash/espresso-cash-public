String toDartType(String originalType) {
  if (originalType.contains('|')) {
    final types = originalType.split('|');
    return toDartType(types.first);
  } else if (originalType.startsWith('RpcResponse')) {
    final regex = RegExp(r'RpcResponse<([^>]+)>');
    final allMatches = regex.allMatches(originalType);
    final match = allMatches.elementAt(0);
    final innerType = toDartType(match.group(1)!);

    return 'RpcResponse<${toDartType(innerType)}>';
  } else if (originalType.startsWith('[]')) {
    return 'List<${toDartType(originalType.substring(2))}>';
  } else if (originalType.startsWith('map')) {
    final regex = RegExp(r'map\[([^\]]+)\](.+)');
    final allMatches = regex.allMatches(originalType);
    final match = allMatches.elementAt(0);
    final keyType = toDartType(match.group(1)!);
    final valType = toDartType(match.group(2)!);
    return 'Map<$keyType, $valType>';
  } else {
    switch (originalType) {
      case 'u64':
      case 'i64':
      case 'u8':
      case 'u16':
        return 'int';
      case 'f64':
        return 'double';
      case 'object':
        return 'Map<String, dynamic>';
      case 'string':
        return 'String';
      case '[string, encoding]|object':
        return 'dynamic';
      case 'boolean':
        return 'bool';
      default:
        return originalType;
    }
  }
}

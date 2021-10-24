String parseType(String originalType) {
  if (originalType.contains('|')) {
    final types = originalType.split('|');
    print(types);
    // FIXME: take all types in consideration
    return parseType(types.first);
  } else if (originalType.startsWith('RpcResponse')) {
    return _fromRpcResponseObject(originalType);
  } else if (originalType.startsWith('[]')) {
    return 'List<${parseType(originalType.substring(2))}>';
  } else if (originalType.startsWith('map')) {
    return _fromMapExpression(originalType);
  } else {
    switch (originalType) {
      case 'u64':
      case 'i64':
      case 'u8':
      case 'u16':
      case 'usize':
        return 'int';
      case 'f64':
        return 'double';
      case 'object':
        return 'Map<String, dynamic>';
      case 'string':
        return 'String';
      case '[string, encoding]|object':
        return 'AccountData';
      case 'boolean':
        return 'bool';
      default:
        return originalType;
    }
  }
}

String _fromRpcResponseObject(String rpcResponse) {
  final regex = RegExp(r'RpcResponse<([^>]+)>');
  final allMatches = regex.allMatches(rpcResponse);
  final match = allMatches.elementAt(0);
  final innerType = parseType(match.group(1)!);

  return parseType(innerType);
}

String _fromMapExpression(String mapExpression) {
  final regex = RegExp(r'map\[([^\]]+)\](.+)');
  final allMatches = regex.allMatches(mapExpression);
  final match = allMatches.elementAt(0);
  final keyType = parseType(match.group(1)!);
  final valType = parseType(match.group(2)!);

  return 'Map<$keyType, $valType>';
}

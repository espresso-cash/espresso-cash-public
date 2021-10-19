String toDartType(String originalType) {
  if (originalType == '[string, encoding]') {
    return 'AccountData';
  } else if (originalType.contains('|')) {
    final types = originalType.split('|');
    // FIXME: take all types in consideration
    return toDartType(types.first);
  } else if (originalType.startsWith('RpcResponse')) {
    return _fromRpcResponseObject(originalType);
  } else if (originalType.startsWith('[]')) {
    return 'List<${toDartType(originalType.substring(2))}>';
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
  final innerType = toDartType(match.group(1)!);

  return toDartType(innerType);
}

String _fromMapExpression(String mapExpression) {
  final regex = RegExp(r'map\[([^\]]+)\](.+)');
  final allMatches = regex.allMatches(mapExpression);
  final match = allMatches.elementAt(0);
  final keyType = toDartType(match.group(1)!);
  final valType = toDartType(match.group(2)!);

  return 'Map<$keyType, $valType>';
}

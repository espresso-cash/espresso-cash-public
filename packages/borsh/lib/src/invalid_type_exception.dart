class InvalidTypeException implements Exception {
  const InvalidTypeException({
    required this.wanted,
    required this.found,
  });

  final Type wanted;
  final Type found;
}

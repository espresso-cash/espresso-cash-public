class BadStateException implements Exception {
  const BadStateException(this.message);

  @override
  String toString() => message;

  final String message;
}

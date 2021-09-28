class TransactionException implements Exception {
  TransactionException(this.error);

  final Object error;

  @override
  String toString() => error.toString();
}

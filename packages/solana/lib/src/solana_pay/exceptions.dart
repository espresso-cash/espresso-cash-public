class CreateTransactionException implements Exception {
  const CreateTransactionException(this.message);

  final String message;

  @override
  String toString() => '$CreateTransactionException($message)';
}

class ParseUrlException implements Exception {
  const ParseUrlException(this.message);

  final String message;

  @override
  String toString() => '$ParseUrlException($message)';
}

class ValidateTransactionException implements Exception {
  const ValidateTransactionException(this.message);

  final String message;

  @override
  String toString() => '$ValidateTransactionException($message)';
}

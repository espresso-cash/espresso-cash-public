class CreateTransactionException implements Exception {
  const CreateTransactionException(this.message);

  final String message;
}

class ParseUrlException implements Exception {
  const ParseUrlException(this.message);

  final String message;
}

class ValidateTransactionException implements Exception {
  const ValidateTransactionException(this.message);

  final String message;
}

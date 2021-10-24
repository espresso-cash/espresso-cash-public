class InvalidResponseException implements Exception {
  const InvalidResponseException(this.value);

  @override
  String toString() =>
      'expected a Map<String, dynamic> as a response, but instead there was a ${value.runtimeType}';

  final Object? value;
}

class InvalidResponseResultException implements Exception {
  const InvalidResponseResultException(this.value);

  @override
  String toString() =>
      'expected a Map<String, dynamic> as a response, but instead there was a ${value.runtimeType}';

  final Object? value;
}

class InvalidResultValueException implements Exception {
  const InvalidResultValueException(this.value);

  @override
  String toString() =>
      'expected a Map<String, dynamic> as a response, but instead there was a ${value.runtimeType}';

  final Object? value;
}

class NullResponseException implements Exception {
  @override
  String toString() => 'got a null response in a method expecting a non-null';
}

part of 'exceptions.dart';

class BadStateException implements Exception {
  BadStateException(this.message);

  @override
  String toString() => message;

  final String message;
}

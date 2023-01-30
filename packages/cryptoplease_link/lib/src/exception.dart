class EspressoCashException implements Exception {
  EspressoCashException({required this.code, required this.message});

  final String code;
  final String message;
}

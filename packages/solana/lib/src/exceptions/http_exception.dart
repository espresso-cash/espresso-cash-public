class HttpException implements Exception {
  const HttpException(this._code, this._message);

  final int _code;
  final String _message;

  @override
  String toString() =>
      'http status code $_code, the following content\n\n---\n$_message';
}

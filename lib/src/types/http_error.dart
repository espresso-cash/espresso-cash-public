class HttpError extends Error {
  HttpError(this._code, this._message);

  final int _code;
  final String _message;

  String toString() {
    return 'http status code $_code, the following content\n\n---\n$_message';
  }
}

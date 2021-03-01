class JsonRpcError {
  JsonRpcError(dynamic value) {
    this._message = value['message'];
    this._code = value['code'];
    this._data = value['data'];
  }

  String toString() {
    return 'jsonrpc-2.0 error ($_code): $_message\n\t$_data';
  }

  String _message;
  int _code;
  // FIXME: data can be structured
  dynamic _data;
}

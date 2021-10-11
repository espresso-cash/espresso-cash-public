enum Encoding {
  base64,
  base64zstd,
  jsonParsed,
}

extension EncodingValueExt on Encoding {
  String get value {
    switch (this) {
      case Encoding.base64:
        return 'base64';
      case Encoding.base64zstd:
        return 'base64+zstd';
      case Encoding.jsonParsed:
        return 'jsonParsed';
    }
  }
}

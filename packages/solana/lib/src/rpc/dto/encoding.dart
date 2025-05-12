enum Encoding {
  /// Binary data encoded as base64
  base64,

  /// Attempts to use program-specific state parsers to return more
  /// human-readable and explicit account state data. If [Encoding.jsonParsed]
  /// is requested but a parser cannot be found, the field falls back to
  /// [Encoding.base64] encoding, detectable when the data field type is
  /// `String`.
  jsonParsed,

  /// Binary data encoded as base58.
  ///
  /// Base58 is limited to `AccountData` data of less than 129 bytes.
  base58,
  json,
}

extension EncodingValue on Encoding {
  String get value => switch (this) {
    Encoding.jsonParsed => 'jsonParsed',
    Encoding.base64 => 'base64',
    Encoding.base58 => 'base58',
    Encoding.json => 'json',
  };
}

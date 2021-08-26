enum EncodingType {
  base64,
  base58,
}

extension Serializable on EncodingType {
  String toJson() {
    switch (this) {
      case EncodingType.base64:
        return 'base64';
      case EncodingType.base58:
        return 'base58';
    }
  }
}

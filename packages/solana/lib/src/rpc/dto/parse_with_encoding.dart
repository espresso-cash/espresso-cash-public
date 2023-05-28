import 'dart:convert';

import 'package:solana/src/base58/base58.dart';

T parseWithEncoding<T>(
  dynamic data, {
  required T Function(List<int> data) fromEncoded,
  required T Function(Map<String, dynamic> json) fromParsed,
  T Function(String encoding)? onUnknownEncoding,
}) {
  if (data is List<dynamic>) {
    if (data.length != 2) {
      throw const FormatException(
        'expected an array of 2 elements [data, encoding]',
      );
    }

    final elements = data.whereType<String>();
    if (elements.length != 2) {
      throw const FormatException(
        'array has two elements but of incompatible types',
      );
    }

    final dynamic encoded = data.first;
    final dynamic encoding = data.last;
    if (encoded is! String) {
      throw const FormatException('encoded data is not of type String');
    }

    if (encoding is! String) {
      throw const FormatException('encoding is not of type String');
    }

    if (encoding == 'base64') {
      return fromEncoded(_normalized(encoded));
    } else if (encoding == 'base58') {
      return fromEncoded(base58decode(encoded));
    }

    if (onUnknownEncoding != null) {
      return onUnknownEncoding(encoding);
    }

    throw FormatException('unknown encoding $encoding');
  } else if (data is Map<String, dynamic>) {
    // In this case this is more convenient than a redirecting factory
    return fromParsed(data);
  } else if (data is String) {
    return fromEncoded(_normalized(data));
  }

  throw const FormatException('account data is in unknown format');
}

List<int> _normalized(String data) {
  // We need to normalize because the padding bytes are not
  // included
  final normalized = base64.normalize(data);

  return base64.decode(normalized);
}

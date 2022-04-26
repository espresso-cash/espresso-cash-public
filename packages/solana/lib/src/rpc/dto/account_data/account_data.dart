import 'dart:convert';

import 'package:solana/src/base58/decode.dart' show base58decode;
import 'package:solana/src/rpc/dto/account_data/binary_account_data.dart';
import 'package:solana/src/rpc/dto/account_data/empty_account_data.dart';
import 'package:solana/src/rpc/dto/account_data/parsed_account_data.dart';

export 'binary_account_data.dart';
export 'empty_account_data.dart';
export 'parsed_account_data.dart';
export 'spl_token_program/spl_token_program.dart';
export 'stake_program/stake_program.dart';

abstract class AccountData {
  const factory AccountData.binary(List<int> bytes) = BinaryAccountData;

  const factory AccountData.empty() = EmptyAccountData;

  factory AccountData._fromBase64String(String base64String) {
    // We need to normalize because the padding bytes are not
    // included
    final normalized = base64.normalize(base64String);

    return AccountData.binary(base64.decode(normalized));
  }

  factory AccountData._fromEncodedData(Iterable<String> data) {
    final dynamic encoded = data.first;
    final dynamic encoding = data.last;
    if (encoded is! String) {
      throw const FormatException('encoded data is not of type String');
    }

    if (encoding is! String) {
      throw const FormatException('encoding is not of type String');
    }

    if (encoding.isEmpty) {
      return const AccountData.empty();
    }

    if (encoding == 'base64') {
      return AccountData._fromBase64String(encoded);
    } else if (encoding == 'base58') {
      return AccountData.binary(base58decode(encoded));
    } else {
      throw FormatException('unknown encoding $encoding');
    }
  }

  factory AccountData.fromJson(dynamic data) {
    if (data == null) {
      // Null data should be handled by making the data field nullable
      throw const FormatException('unexpected null account data');
    } else if (data is List<dynamic>) {
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

      return AccountData._fromEncodedData(elements);
    } else if (data is Map<String, dynamic>) {
      // In this case this is more convenient than a redirecting factory
      return ParsedAccountData.fromJson(data);
    } else if (data is String) {
      return AccountData._fromBase64String(data);
    } else {
      throw const FormatException('account data is in unknown format');
    }
  }
}

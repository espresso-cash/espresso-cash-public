import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/base58/decode.dart';
import 'package:solana/src/dto/parsed_spl_token_account_data.dart';

part 'account_data.freezed.dart';
part 'account_data.g.dart';

@freezed
class AccountData with _$AccountData {
  const factory AccountData.binary(List<int> bytes) = BinaryAccountData;

  const factory AccountData.jsonParsed(ParsedAccountDataParsed jsonParsed) =
      ParsedAccountData;

  const factory AccountData.empty() = EmptyAccountData;
}

@Freezed(unionKey: 'program', fallbackUnion: 'unsupported')
class ParsedAccountDataParsed with _$ParsedAccountDataParsed {
  @FreezedUnionValue('spl-token')
  const factory ParsedAccountDataParsed.splToken(
    ParsedSplTokenAccountData parsed,
  ) = SplTokenAccountData;

  const factory ParsedAccountDataParsed.unsupported() =
      UnsupportedParsedAccountData;

  factory ParsedAccountDataParsed.fromJson(Map<String, dynamic> json) =>
      _$ParsedAccountDataParsedFromJson(json);
}

class AccountDataConverter implements JsonConverter<AccountData?, dynamic> {
  const AccountDataConverter();

  AccountData _fromEncodedData(List<String> data) {
    final dynamic encoded = data.first;
    final dynamic encoding = data.last;
    if (encoded is! String) {
      throw const FormatException('encoded data is not of type String');
    }

    if (encoding is! String) {
      throw const FormatException('encoding is not of type String');
    }

    if (encoding == 'base64') {
      if (encoded is! String) {
        throw FormatException('unexpected data "${data.first}"');
      }

      if (encoded.isEmpty) {
        return const AccountData.empty();
      }

      return AccountData.binary(base58decode(encoded));
    } else if (encoding == 'base58') {
      if (encoded is! String) {
        throw FormatException('unexpected data "${data.first}"');
      }

      if (encoding.isEmpty) {
        return const AccountData.empty();
      }

      return AccountData.binary(base64Decode(encoded));
    } else {
      throw FormatException('unknown encoding $encoding');
    }
  }

  @override
  AccountData? fromJson(dynamic data) {
    if (data == null) {
      return null;
    } else if (data == '') {
      return const AccountData.empty();
    } else if (data is List<dynamic>) {
      if (data.length != 2) {
        throw const FormatException(
          'expected an array of 2 elements [data, encoding]',
        );
      }

      final asStrings = data.whereType<String>().toList(growable: false);
      if (asStrings.length != 2) {
        throw const FormatException(
            'array has two elements but of incompatible types');
      }

      return _fromEncodedData(asStrings);
    } else if (data is Map<String, dynamic>) {
      return AccountData.jsonParsed(
        ParsedAccountDataParsed.fromJson(data),
      );
    } else {
      throw const FormatException('account data is in unknown format');
    }
  }

  @override
  dynamic toJson(AccountData? object) {
    throw UnsupportedError('converting account data to json is not supported');
  }
}

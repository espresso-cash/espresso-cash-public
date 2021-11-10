import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/dto/parsed_spl_token_account_data.dart';

part 'account_data.freezed.dart';

@freezed
class AccountData with _$AccountData {
  const factory AccountData.fromBytes(List<int> bytes) = BinaryAccountData;

  const factory AccountData.fromString(String string) = StringAccountData;

  const factory AccountData.empty() = EmptyAccountData;

  const factory AccountData.splToken(ParsedSplTokenAccountData parsed) =
      SplTokenAccountData;

  const factory AccountData.generic(Map<String, dynamic> data) =
      GenericAccountData;
}

class AccountDataConverter implements JsonConverter<AccountData?, dynamic> {
  const AccountDataConverter();

  @override
  AccountData? fromJson(dynamic data) {
    if (data == null) {
      return null;
    } else if (data is String) {
      if (data == '') {
        return const AccountData.empty();
      }
      return AccountData.fromBytes(base64Decode(data));
    } else if (data is List) {
      if (data.length != 2) {
        throw const FormatException(
            'unexpected array of strings, cannot be account data');
      }
      if (data.last != 'base64') {
        throw FormatException('unexpected encoding "${data.last}"');
      }
      final dynamic base64String = data.first;
      if (base64String is! String) {
        throw FormatException('unexpected data "${data.first}"');
      }
      return AccountData.fromBytes(base64Decode(base64String));
    } else if (data is Map<String, dynamic>) {
      switch (data['program']) {
        // TODO(IA): add other program data
        case 'spl-token':
          return AccountData.splToken(ParsedSplTokenAccountData.fromJson(
            data['parsed'] as Map<String, dynamic>,
          ));
        default:
          return AccountData.generic(data);
      }
    } else {
      throw const FormatException('cannot decode account data');
    }
  }

  @override
  Map<String, dynamic> toJson(AccountData? object) {
    throw UnsupportedError('converting this object to json is not supported');
  }
}

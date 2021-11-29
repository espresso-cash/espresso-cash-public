import 'package:json_annotation/json_annotation.dart';

part 'account_key.g.dart';

/// A commonly used object that stores a single [pubkey]
abstract class AccountKey {
  factory AccountKey.fromJson(dynamic json) {
    if (json is String) {
      return _AccountKey(pubkey: json);
    } else {
      return ParsedAccountKey.fromJson(json as Map<String, dynamic>);
    }
  }

  abstract final String pubkey;
}

@JsonSerializable()
class ParsedAccountKey implements AccountKey {
  const ParsedAccountKey({
    required this.pubkey,
  });

  factory ParsedAccountKey.fromJson(Map<String, dynamic> json) =>
      _$ParsedAccountKeyFromJson(json);

  final String pubkey;
}

class _AccountKey implements AccountKey {
  const _AccountKey({
    required this.pubkey,
  });

  final String pubkey;
}

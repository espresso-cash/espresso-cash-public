import 'package:json_annotation/json_annotation.dart';

part 'account_key.g.dart';

/// A commonly used object that stores a single [pubkey]
@JsonSerializable()
class AccountKey {
  AccountKey({
    required this.pubkey,
  });

  factory AccountKey.fromJson(Map<String, dynamic> json) =>
      _$AccountKeyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AccountKeyToJson(this);

  final String pubkey;
}

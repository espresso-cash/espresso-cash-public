part of 'rpc_client.dart';

@JsonSerializable(createToJson: false)
class AccountKey {
  AccountKey({
    required this.pubkey,
  });

  factory AccountKey.fromJson(Map<String, dynamic> json) =>
      _$AccountKeyFromJson(json);

  final String pubkey;
}

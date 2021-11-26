import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/account.dart';

part 'account_with_pubkey.g.dart';

@JsonSerializable(createToJson: false)
class AccountWithPubkey {
  AccountWithPubkey({
    required this.account,
    required this.pubkey,
  });

  factory AccountWithPubkey.fromJson(Map<String, dynamic> json) =>
      _$AccountWithPubkeyFromJson(json);

  final Account account;
  final String pubkey;
}

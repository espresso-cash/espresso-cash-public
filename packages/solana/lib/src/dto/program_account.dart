import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/account.dart';

part 'program_account.g.dart';

/// A program account
@JsonSerializable(createFactory: true, includeIfNull: false)
class ProgramAccount {
  const ProgramAccount({
    required this.account,
    required this.pubkey,
  });

  factory ProgramAccount.fromJson(Map<String, dynamic> json) =>
      _$ProgramAccountFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramAccountToJson(this);

  /// The account information for this program account.
  final Account account;

  /// The account Pubkey as base-58 encoded string.
  final String pubkey;
}

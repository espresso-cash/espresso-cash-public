import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/account.dart';
import 'package:solana/src/rpc/dto/context.dart';

part 'program_account.g.dart';

/// A program account
@JsonSerializable()
class ProgramAccount {
  const ProgramAccount({
    required this.account,
    required this.pubkey,
  });

  factory ProgramAccount.fromJson(Map<String, dynamic> json) =>
      _$ProgramAccountFromJson(json);

  /// The account information for this program account.
  final Account account;

  /// The account Pubkey as base-58 encoded string.
  final String pubkey;

  Map<String, dynamic> toJson() => _$ProgramAccountToJson(this);
}

@JsonSerializable()
class ProgramAccountsResult extends ContextResult<List<ProgramAccount>> {
  const ProgramAccountsResult({required super.context, required super.value});

  factory ProgramAccountsResult.fromJson(Map<String, dynamic> json) =>
      _$ProgramAccountsResultFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramAccountsResultToJson(this);
}

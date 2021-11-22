import 'package:json_annotation/json_annotation.dart';

part 'token_accounts_filter.g.dart';

/// Either a mint or a program id
@JsonSerializable(createFactory: true, includeIfNull: false)
class TokenAccountsFilter {
  const TokenAccountsFilter({
    this.mint,
    this.programId,
  });

  factory TokenAccountsFilter.fromJson(Map<String, dynamic> json) =>
      _$TokenAccountsFilterFromJson(json);

  Map<String, dynamic> toJson() => _$TokenAccountsFilterToJson(this);

  /// Pubkey of the specific token Mint to limit accounts to, as
  /// base-58 encoded string; or
  final String? mint;

  /// Pubkey of the Token program ID that owns the accounts, as
  /// base-58 encoded string
  final String? programId;
}

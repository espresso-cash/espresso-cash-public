import 'package:json_annotation/json_annotation.dart';

part 'token_accounts_filter.g.dart';

/// Either a mint or a program id
abstract class TokenAccountsFilter {
  const factory TokenAccountsFilter.byMint(String mint) =
      TokenAccountsFilterByMint;

  const factory TokenAccountsFilter.byProgramId(String programId) =
      TokenAccountsFilterByProgramId;

  Map<String, dynamic> toJson();
}

@JsonSerializable(createFactory: false)
class TokenAccountsFilterByProgramId implements TokenAccountsFilter {
  const TokenAccountsFilterByProgramId(this.programId);

  @override
  Map<String, dynamic> toJson() => _$TokenAccountsFilterByProgramIdToJson(this);

  /// Pubkey of the Token program ID that owns the accounts, as
  /// base-58 encoded string
  final String programId;
}

@JsonSerializable(createFactory: false)
class TokenAccountsFilterByMint implements TokenAccountsFilter {
  const TokenAccountsFilterByMint(this.mint);

  @override
  Map<String, dynamic> toJson() => _$TokenAccountsFilterByMintToJson(this);

  /// Pubkey of the specific token Mint to limit accounts to, as
  /// base-58 encoded string; or
  final String mint;
}

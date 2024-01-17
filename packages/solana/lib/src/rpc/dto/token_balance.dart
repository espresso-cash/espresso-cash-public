import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/token_amount.dart';

part 'token_balance.g.dart';

/// The balance of a SPL token account
@JsonSerializable()
class TokenBalance {
  const TokenBalance({
    required this.accountIndex,
    required this.mint,
    required this.uiTokenAmount,
  });

  factory TokenBalance.fromJson(Map<String, dynamic> json) =>
      _$TokenBalanceFromJson(json);

  /// Index of the account in which the token balance is provided
  /// for.
  final int accountIndex;

  /// Pubkey of the token's mint.
  final String mint;

  /// Token balance
  final TokenAmount uiTokenAmount;

  Map<String, dynamic> toJson() => _$TokenBalanceToJson(this);
}

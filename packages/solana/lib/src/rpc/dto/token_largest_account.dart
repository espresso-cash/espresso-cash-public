import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/context.dart';

part 'token_largest_account.g.dart';

@JsonSerializable(createToJson: false)
class TokenLargestAccount {
  const TokenLargestAccount({
    required this.address,
    required this.amount,
    required this.decimals,
    required this.uiAmountString,
  });

  factory TokenLargestAccount.fromJson(Map<String, dynamic> json) =>
      _$TokenLargestAccountFromJson(json);

  final String address;
  final String amount;
  final int decimals;
  final String uiAmountString;
}

@JsonSerializable(createToJson: false)
class TokenLargestAccountsResult
    extends ContextResult<List<TokenLargestAccount>> {
  const TokenLargestAccountsResult({
    required super.context,
    required super.value,
  });

  factory TokenLargestAccountsResult.fromJson(Map<String, dynamic> json) =>
      _$TokenLargestAccountsResultFromJson(json);
}

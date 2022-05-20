import 'package:json_annotation/json_annotation.dart';

part 'token_largest_account.g.dart';

@JsonSerializable(createToJson: false)
class TokenLargestAccount {
  TokenLargestAccount({
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

import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_balance.freezed.dart';
part 'token_balance.g.dart';

@freezed
class TokenBalance with _$TokenBalance {
  const factory TokenBalance({
    required String id,
    required String symbol,
    required int balance,
  }) = _TokenBalance;

  factory TokenBalance.fromJson(Map<String, dynamic> json) =>
      _$TokenBalanceFromJson(json);
}

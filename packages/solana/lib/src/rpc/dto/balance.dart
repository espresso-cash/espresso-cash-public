import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/context.dart';

part 'balance.g.dart';

@JsonSerializable()
class BalanceResult extends ContextResult<int> {
  const BalanceResult({required super.context, required super.value});

  factory BalanceResult.fromJson(Map<String, dynamic> json) =>
      _$BalanceResultFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceResultToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/dto.dart';

part 'stake_minimum_delegation.g.dart';

@JsonSerializable(createToJson: false)
class StakeMinimumDelegationResult extends ContextResult<int> {
  const StakeMinimumDelegationResult({
    required super.context,
    required super.value,
  });

  factory StakeMinimumDelegationResult.fromJson(Map<String, dynamic> json) =>
      _$StakeMinimumDelegationResultFromJson(json);
}

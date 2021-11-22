import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';

part 'get_stake_activation_options.g.dart';

/// Configuration object for [RPCClient.getStakeActivation()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetStakeActivationOptions {
  const GetStakeActivationOptions({
    this.commitment,
    this.epoch,
  });

  factory GetStakeActivationOptions.fromJson(Map<String, dynamic> json) =>
      _$GetStakeActivationOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetStakeActivationOptionsToJson(this);

  final Commitment? commitment;

  /// epoch for which to calculate activation details. If
  /// parameter not provided, defaults to current epoch.
  final int? epoch;
}

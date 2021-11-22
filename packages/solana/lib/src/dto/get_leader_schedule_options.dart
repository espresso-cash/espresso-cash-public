import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';

part 'get_leader_schedule_options.g.dart';

/// Configuration object for [RPCClient.getLeaderSchedule()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetLeaderScheduleOptions {
  const GetLeaderScheduleOptions({
    this.commitment,
    this.identity,
  });

  factory GetLeaderScheduleOptions.fromJson(Map<String, dynamic> json) =>
      _$GetLeaderScheduleOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetLeaderScheduleOptionsToJson(this);

  final Commitment? commitment;

  /// Only return results for this validator identity (base-58
  /// encoded)
  final String? identity;
}

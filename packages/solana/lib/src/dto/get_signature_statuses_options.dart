import 'package:json_annotation/json_annotation.dart';

part 'get_signature_statuses_options.g.dart';

/// Configuration object for [RPCClient.getStakeActivation()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetSignatureStatusesOptions {
  const GetSignatureStatusesOptions({
    this.searchTransactionHistory,
  });

  factory GetSignatureStatusesOptions.fromJson(Map<String, dynamic> json) =>
      _$GetSignatureStatusesOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSignatureStatusesOptionsToJson(this);

  /// If true, a Solana node will search its ledger cache for any
  /// signatures not found in the recent status cache
  final bool? searchTransactionHistory;
}

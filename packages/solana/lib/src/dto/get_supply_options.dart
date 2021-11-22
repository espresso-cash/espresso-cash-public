import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';

part 'get_supply_options.g.dart';

/// Configuration object for [RPCClient.getVoteAccounts()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetSupplyOptions {
  const GetSupplyOptions({
    required this.commitment,
    this.excludeNonCirculatingAccountsList,
  });

  factory GetSupplyOptions.fromJson(Map<String, dynamic> json) =>
      _$GetSupplyOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSupplyOptionsToJson(this);

  final Commitment commitment;

  /// exclude non circulating accounts list from response
  final bool? excludeNonCirculatingAccountsList;
}

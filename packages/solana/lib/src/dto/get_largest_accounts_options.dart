import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/circulation_status.dart';
import 'package:solana/src/dto/commitment.dart';

part 'get_largest_accounts_options.g.dart';

/// Configuration object for [RPCClient.getLargestAccounts()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetLargestAccountsOptions {
  const GetLargestAccountsOptions({
    this.commitment,
    this.filter,
  });

  factory GetLargestAccountsOptions.fromJson(Map<String, dynamic> json) =>
      _$GetLargestAccountsOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetLargestAccountsOptionsToJson(this);

  final Commitment? commitment;

  /// filter results by account type; currently supported:
  /// circulating|nonCirculating
  final CirculationStatus? filter;
}

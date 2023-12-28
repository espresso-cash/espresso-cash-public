import 'package:json_annotation/json_annotation.dart';

part 'spl_token_transfer_info.g.dart';

/// Information about a [spl token] transfer
///
/// [spl token]: https://spl.solana.com/token
/// [Detailed implementation]: https://docs.rs/solana-transaction-status/latest/src/solana_transaction_status/parse_token.rs.html#161-162
@JsonSerializable()
class SplTokenTransferInfo {
  const SplTokenTransferInfo({
    required this.amount,
    required this.source,
    required this.destination,
    this.authority,
    this.multisigAuthority,
    this.signers,
  });

  factory SplTokenTransferInfo.fromJson(Map<String, dynamic> json) =>
      _$SplTokenTransferInfoFromJson(json);

  final String amount;
  final String source;
  final String destination;

  /// If [authority] is not available (null), then [multisigAuthority] and
  /// [signers] will be provided. Otherwise [multisigAuthority] and [signers]
  /// will be `null` and [authority] will be provided.
  final String? authority;
  final String? multisigAuthority;
  final List<String>? signers;

  /// If [authority] is not provided, [multisigAuthority] must be provided. And vice versa.
  // ignore: avoid-non-null-assertion, either authority or multisigAuthority should not be null
  String get singleAuthority => authority ?? multisigAuthority!;
}

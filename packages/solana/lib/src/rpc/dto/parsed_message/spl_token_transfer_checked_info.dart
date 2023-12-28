import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/token_amount.dart';

part 'spl_token_transfer_checked_info.g.dart';

/// Information about a [spl token] transfer
///
/// [spl token]: https://spl.solana.com/token
/// [Detailed implementation]: https://docs.rs/solana-transaction-status/latest/src/solana_transaction_status/parse_token.rs.html#356-357
@JsonSerializable()
class SplTokenTransferCheckedInfo {
  const SplTokenTransferCheckedInfo({
    required this.tokenAmount,
    required this.source,
    required this.destination,
    required this.mint,
    this.authority,
    this.multisigAuthority,
    this.signers,
  });

  factory SplTokenTransferCheckedInfo.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SplTokenTransferCheckedInfoFromJson(json);

  final TokenAmount tokenAmount;
  final String source;
  final String destination;
  final String mint;

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

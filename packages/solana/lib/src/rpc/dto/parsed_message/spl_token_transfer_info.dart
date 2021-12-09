import 'package:json_annotation/json_annotation.dart';

part 'spl_token_transfer_info.g.dart';

/// Information about a [spl token] transfer
///
/// [spl token]: https://spl.solana.com/token
@JsonSerializable()
class SplTokenTransferInfo {
  const SplTokenTransferInfo({
    required this.amount,
    required this.authority,
    required this.mint,
    required this.source,
    required this.destination,
  });

  factory SplTokenTransferInfo.fromJson(Map<String, dynamic> json) =>
      _$SplTokenTransferInfoFromJson(json);

  final String amount;
  final String authority;
  final String? mint;
  final String source;
  final String destination;
}

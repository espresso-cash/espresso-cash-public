import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/token_amount.dart';

part 'spl_token_transfer_checked_info.g.dart';

/// Information about a [spl token] transfer
///
/// [spl token]: https://spl.solana.com/token
@JsonSerializable()
class SplTokenTransferCheckedInfo {
  const SplTokenTransferCheckedInfo({
    required this.tokenAmount,
    required this.source,
    required this.destination,
  });

  factory SplTokenTransferCheckedInfo.fromJson(Map<String, dynamic> json) =>
      _$SplTokenTransferCheckedInfoFromJson(json);

  final TokenAmount tokenAmount;
  final String source;
  final String destination;

  Map<String, dynamic> toJson() => _$SplTokenTransferCheckedInfoToJson(this);
}

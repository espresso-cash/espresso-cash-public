import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/token_amount.dart';

part 'token_account_data_info.g.dart';

@JsonSerializable(includeIfNull: false)
class SplTokenAccountDataInfo {
  const SplTokenAccountDataInfo({
    required this.tokenAmount,
    required this.state,
    required this.isNative,
    required this.mint,
    required this.owner,
    this.delegate,
    this.delegateAmount,
  });

  factory SplTokenAccountDataInfo.fromJson(Map<String, dynamic> json) =>
      _$SplTokenAccountDataInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SplTokenAccountDataInfoToJson(this);

  final TokenAmount tokenAmount;
  final String state;
  final bool isNative;
  final String mint;
  final String owner;
  final String? delegate;
  final TokenAmount? delegateAmount;
}

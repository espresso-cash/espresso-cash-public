import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/rpc_types.dart';

part 'spl_token_account_data_info.g.dart';

@JsonSerializable()
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

  final TokenAmount tokenAmount;
  final String state;
  final bool isNative;
  final String mint;
  final String owner;
  final String? delegate;
  final TokenAmount? delegateAmount;
}

import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/spl_token/token_amount.dart';

part 'parsed_spl_token_account_data_info.g.dart';

@JsonSerializable()
class ParsedSplTokenAccountDataInfo {
  const ParsedSplTokenAccountDataInfo({
    required this.tokenAmount,
    required this.state,
    required this.isNative,
    required this.mint,
    required this.owner,
    this.delegate,
    this.delegateAmount,
  });

  factory ParsedSplTokenAccountDataInfo.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplTokenAccountDataInfoFromJson(json);

  final TokenAmount tokenAmount;
  final String state;
  final bool isNative;
  final String mint;
  final String owner;
  final String? delegate;
  final TokenAmount? delegateAmount;
}

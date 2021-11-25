import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/token_amount.dart';

part 'parsed_spl_token_account_data_info.g.dart';

@JsonSerializable()
class ParsedSplMintAccountDataInfo {
  const ParsedSplMintAccountDataInfo({
    required this.decimals,
    this.freezeAuthority,
    required this.isInitialized,
    required this.mintAuthority,
    required this.supply,
  });

  factory ParsedSplMintAccountDataInfo.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplMintAccountDataInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ParsedSplMintAccountDataInfoToJson(this);

  final int decimals;
  final String? freezeAuthority;
  final bool isInitialized;
  final String? mintAuthority;
  final String supply;
}

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

  Map<String, dynamic> toJson() => _$ParsedSplTokenAccountDataInfoToJson(this);

  final TokenAmount tokenAmount;
  final String state;
  final bool isNative;
  final String mint;
  final String owner;
  final String? delegate;
  final TokenAmount? delegateAmount;
}

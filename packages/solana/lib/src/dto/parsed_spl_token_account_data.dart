import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/parsed_spl_token_account_data_info.dart';

part 'parsed_spl_token_account_data.g.dart';

@JsonSerializable()
class ParsedSplTokenAccountData {
  const ParsedSplTokenAccountData({
    required this.info,
    required this.type,
    required this.accountType,
  });

  factory ParsedSplTokenAccountData.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplTokenAccountDataFromJson(json);

  final ParsedSplTokenAccountDataInfo info;
  final String type;
  final String? accountType;
}

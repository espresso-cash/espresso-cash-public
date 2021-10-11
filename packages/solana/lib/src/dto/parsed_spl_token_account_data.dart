import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/parsed_spl_token_account_data_info.dart';

part 'parsed_spl_token_account_data.g.dart';

@JsonSerializable()
class ParsedSplTokenAccountData {
  const ParsedSplTokenAccountData({
    required this.accountType,
    required this.info,
    required this.type,
  });

  factory ParsedSplTokenAccountData.fromJson(Map<String, dynamic> data) =>
      _$ParsedSplTokenAccountDataFromJson(data);

  final String? accountType;
  final ParsedSplTokenAccountDataInfo info;
  final String type;
}

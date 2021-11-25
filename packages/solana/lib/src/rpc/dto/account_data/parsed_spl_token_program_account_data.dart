import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/rpc/dto/account_data/parsed_spl_token_account_data_info.dart';

part 'parsed_spl_token_program_account_data.freezed.dart';

part 'parsed_spl_token_program_account_data.g.dart';

@Freezed(unionKey: 'type', fallbackUnion: 'unknown')
class ParsedSplTokenProgramAccountData with _$ParsedSplTokenProgramAccountData {
  const factory ParsedSplTokenProgramAccountData.account({
    required ParsedSplTokenAccountDataInfo info,
    required String type,
    String? accountType,
  }) = TokenAccountData;

  const factory ParsedSplTokenProgramAccountData.mint({
    required ParsedSplMintAccountDataInfo info,
    required String type,
    String? accountType,
  }) = MintAccountData;

  const factory ParsedSplTokenProgramAccountData.unknown({
    required String type,
  }) = UnknownAccountData;

  factory ParsedSplTokenProgramAccountData.fromJson(
      Map<String, dynamic> data,) =>
      _$ParsedSplTokenProgramAccountDataFromJson(data);

  Map<String, dynamic> toJson() {
    throw const FormatException('not serializable');
  }
}

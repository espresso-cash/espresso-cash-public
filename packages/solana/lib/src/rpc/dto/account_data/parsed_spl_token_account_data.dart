import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/rpc/dto/account_data/mint_account_data_info.dart';
import 'package:solana/src/rpc/dto/account_data/spl_token_account_data_info.dart';

part 'parsed_spl_token_account_data.freezed.dart';
part 'parsed_spl_token_account_data.g.dart';

@Freezed(unionKey: 'type', fallbackUnion: 'splToken')
class ParsedSplTokenAccountData with _$ParsedSplTokenAccountData {
  const factory ParsedSplTokenAccountData.mint({
    required MintAccountDataInfo info,
    final String? accountType,
  }) = ParsedMintAccountData;

  const factory ParsedSplTokenAccountData.splToken({
    required SplTokenAccountDataInfo info,
    final String? accountType,
  }) = SplTokenAccountData;

  factory ParsedSplTokenAccountData.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplTokenAccountDataFromJson(json);
}

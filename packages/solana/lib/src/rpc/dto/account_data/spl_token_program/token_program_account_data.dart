import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/rpc/dto/account_data/spl_token_program/mint_account_data_info.dart';
import 'package:solana/src/rpc/dto/account_data/spl_token_program/token_account_data_info.dart';

part 'token_program_account_data.freezed.dart';
part 'token_program_account_data.g.dart';

@Freezed(unionKey: 'type', fallbackUnion: 'unknown')
class SplTokenProgramAccountData with _$SplTokenProgramAccountData {
  const factory SplTokenProgramAccountData.account({
    required SplTokenAccountDataInfo info,
    required String type,
    String? accountType,
  }) = TokenAccountData;

  const factory SplTokenProgramAccountData.mint({
    required MintAccountDataInfo info,
    required String type,
    String? accountType,
  }) = MintAccountData;

  const factory SplTokenProgramAccountData.unknown({
    required String type,
  }) = UnknownAccountData;

  factory SplTokenProgramAccountData.fromJson(
    Map<String, dynamic> data,
  ) =>
      _$SplTokenProgramAccountDataFromJson(data);
}

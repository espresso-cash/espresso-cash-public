import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/rpc/dto/account_data/account_data.dart';

part 'parsed_account_data.freezed.dart';
part 'parsed_account_data.g.dart';

@Freezed(unionKey: 'program', fallbackUnion: 'unsupported')
class ParsedAccountData with _$ParsedAccountData implements AccountData {
  @FreezedUnionValue('spl-token')
  const factory ParsedAccountData.splToken(
    SplTokenProgramAccountData parsed,
  ) = ParsedSplTokenProgramAccountData;

  @FreezedUnionValue('spl-token-2022')
  const factory ParsedAccountData.token2022(
    SplTokenProgramAccountData parsed,
  ) = ParsedSplToken2022ProgramAccountData;

  const factory ParsedAccountData.stake(
    StakeProgramAccountData parsed,
  ) = ParsedStakeProgramAccountData;

  const factory ParsedAccountData.unsupported(
    Map<String, dynamic> parsed,
  ) = UnsupportedProgramAccountData;

  factory ParsedAccountData.fromJson(Map<String, dynamic> json) =>
      _$ParsedAccountDataFromJson(json);
}

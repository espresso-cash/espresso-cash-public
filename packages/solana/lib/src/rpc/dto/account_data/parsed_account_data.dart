import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/rpc/dto/account_data.dart';
import 'package:solana/src/rpc/dto/account_data/parsed_spl_token_program_account_data.dart';
import 'package:solana/src/rpc/dto/account_data/parsed_stake_account_data.dart';

part 'parsed_account_data.freezed.dart';
part 'parsed_account_data.g.dart';

@Freezed(unionKey: 'program', fallbackUnion: 'unsupported')
class ParsedAccountData with _$ParsedAccountData implements AccountData {
  @FreezedUnionValue('spl-token')
  const factory ParsedAccountData.splToken(
    ParsedSplTokenProgramAccountData parsed,
  ) = SplTokenProgramAccountData;

  const factory ParsedAccountData.stake(
    ParsedStakeAccountData parsed,
  ) = StakeProgramAccountData;

  const factory ParsedAccountData.unsupported(
    Map<String, dynamic> parsed,
  ) = UnsupportedProgramAccountData;

  factory ParsedAccountData.fromJson(Map<String, dynamic> json) =>
      _$ParsedAccountDataFromJson(json);

  const ParsedAccountData._();

  dynamic get info => map<dynamic>(
        splToken: (parsed) => parsed.info,
        stake: (parsed) => parsed.info,
        unsupported: (parsed) => parsed,
      );
}

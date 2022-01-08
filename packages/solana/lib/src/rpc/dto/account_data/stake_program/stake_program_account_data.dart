import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/stake_delegated_account_info.dart';
import 'package:solana/src/rpc/dto/account_data/stake_program/stake_initialized_account_info.dart';

part 'stake_program_account_data.freezed.dart';
part 'stake_program_account_data.g.dart';

@Freezed(unionKey: 'type', fallbackUnion: 'unknown')
class StakeProgramAccountData with _$StakeProgramAccountData {
  const factory StakeProgramAccountData.delegated({
    required StakeDelegatedAccountInfo info,
  }) = StakeProgramDelegatedAccountData;

  const factory StakeProgramAccountData.initialize({
    required StakeInitializedAccountInfo info,
  }) = StakeProgramInitializedAccountData;

  const factory StakeProgramAccountData.unknown(Map<String, dynamic> info) =
      StakeProgramUnknownAccountData;

  factory StakeProgramAccountData.fromJson(Map<String, dynamic> json) =>
      _$StakeProgramAccountDataFromJson(json);
}

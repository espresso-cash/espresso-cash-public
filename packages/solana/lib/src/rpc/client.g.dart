// @dart=3.9
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GetAccountInfoConfigToJson(GetAccountInfoConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment]!,
      'encoding': ?_$EncodingEnumMap[instance.encoding],
      'dataSlice': ?instance.dataSlice?.toJson(),
      'minContextSlot': ?instance.minContextSlot,
    };

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};

const _$EncodingEnumMap = {
  Encoding.base64: 'base64',
  Encoding.jsonParsed: 'jsonParsed',
  Encoding.base58: 'base58',
  Encoding.json: 'json',
};

Map<String, dynamic> _$GetBalanceConfigToJson(GetBalanceConfig instance) => <String, dynamic>{
  'commitment': ?_$CommitmentEnumMap[instance.commitment],
  'minContextSlot': ?instance.minContextSlot,
};

Map<String, dynamic> _$GetBlockConfigToJson(GetBlockConfig instance) => <String, dynamic>{
  'encoding': ?_$EncodingEnumMap[instance.encoding],
  'transactionDetails': ?_$TransactionDetailLevelEnumMap[instance.transactionDetails],
  'rewards': ?instance.rewards,
  'commitment': ?_$CommitmentEnumMap[instance.commitment],
  'maxSupportedTransactionVersion': ?instance.maxSupportedTransactionVersion,
};

const _$TransactionDetailLevelEnumMap = {
  TransactionDetailLevel.none: 'none',
  TransactionDetailLevel.full: 'full',
  TransactionDetailLevel.signatures: 'signatures',
};

Map<String, dynamic> _$GetBlockHeightConfigToJson(GetBlockHeightConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'minContextSlot': ?instance.minContextSlot,
    };

Map<String, dynamic> _$GetBlockProductionConfigToJson(GetBlockProductionConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'range': ?instance.range?.toJson(),
      'identity': ?instance.identity,
    };

Map<String, dynamic> _$GetBlocksConfigToJson(GetBlocksConfig instance) => <String, dynamic>{
  'commitment': ?_$CommitmentEnumMap[instance.commitment],
};

Map<String, dynamic> _$GetBlocksWithLimitConfigToJson(GetBlocksWithLimitConfig instance) =>
    <String, dynamic>{'commitment': ?_$CommitmentEnumMap[instance.commitment]};

Map<String, dynamic> _$GetEpochInfoConfigToJson(GetEpochInfoConfig instance) => <String, dynamic>{
  'commitment': ?_$CommitmentEnumMap[instance.commitment],
  'minContextSlot': ?instance.minContextSlot,
};

Map<String, dynamic> _$GetFeeForMessageConfigToJson(GetFeeForMessageConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'minContextSlot': ?instance.minContextSlot,
    };

Map<String, dynamic> _$GetInflationGovernorConfigToJson(GetInflationGovernorConfig instance) =>
    <String, dynamic>{'commitment': ?_$CommitmentEnumMap[instance.commitment]};

Map<String, dynamic> _$GetInflationRewardConfigToJson(GetInflationRewardConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'epoch': ?instance.epoch,
      'minContextSlot': ?instance.minContextSlot,
    };

Map<String, dynamic> _$GetLargestAccountsConfigToJson(GetLargestAccountsConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'filter': ?_$CirculationStatusEnumMap[instance.filter],
    };

const _$CirculationStatusEnumMap = {
  CirculationStatus.circulating: 'circulating',
  CirculationStatus.nonCirculating: 'nonCirculating',
};

Map<String, dynamic> _$GetLatestBlockhashConfigToJson(GetLatestBlockhashConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'minContextSlot': ?instance.minContextSlot,
    };

Map<String, dynamic> _$GetLeaderScheduleConfigToJson(GetLeaderScheduleConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'identity': ?instance.identity,
    };

Map<String, dynamic> _$GetMinimumBalanceForRentExemptionConfigToJson(
  GetMinimumBalanceForRentExemptionConfig instance,
) => <String, dynamic>{'commitment': ?_$CommitmentEnumMap[instance.commitment]};

Map<String, dynamic> _$GetMultipleAccountsConfigToJson(GetMultipleAccountsConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment]!,
      'encoding': ?_$EncodingEnumMap[instance.encoding],
      'dataSlice': ?instance.dataSlice?.toJson(),
      'minContextSlot': ?instance.minContextSlot,
    };

Map<String, dynamic> _$GetProgramAccountsConfigToJson(GetProgramAccountsConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'encoding': _$EncodingEnumMap[instance.encoding]!,
      'dataSlice': ?instance.dataSlice?.toJson(),
      'filters': ?instance.filters?.map((e) => e.toJson()).toList(),
      'withContext': ?instance.withContext,
      'minContextSlot': ?instance.minContextSlot,
    };

Map<String, dynamic> _$GetSignaturesForAddressConfigToJson(
  GetSignaturesForAddressConfig instance,
) => <String, dynamic>{
  'limit': ?instance.limit,
  'before': ?instance.before,
  'until': ?instance.until,
  'commitment': ?_$CommitmentEnumMap[instance.commitment],
  'minContextSlot': ?instance.minContextSlot,
};

Map<String, dynamic> _$GetSignatureStatusesConfigToJson(GetSignatureStatusesConfig instance) =>
    <String, dynamic>{'searchTransactionHistory': ?instance.searchTransactionHistory};

Map<String, dynamic> _$GetSlotConfigToJson(GetSlotConfig instance) => <String, dynamic>{
  'commitment': ?_$CommitmentEnumMap[instance.commitment],
  'minContextSlot': ?instance.minContextSlot,
};

Map<String, dynamic> _$GetSlotLeaderConfigToJson(GetSlotLeaderConfig instance) => <String, dynamic>{
  'commitment': ?_$CommitmentEnumMap[instance.commitment],
  'minContextSlot': ?instance.minContextSlot,
};

Map<String, dynamic> _$GetStakeMinimumDelegationConfigToJson(
  GetStakeMinimumDelegationConfig instance,
) => <String, dynamic>{'commitment': ?_$CommitmentEnumMap[instance.commitment]};

Map<String, dynamic> _$GetSupplyConfigToJson(GetSupplyConfig instance) => <String, dynamic>{
  'commitment': _$CommitmentEnumMap[instance.commitment]!,
  'excludeNonCirculatingAccountsList': ?instance.excludeNonCirculatingAccountsList,
};

Map<String, dynamic> _$GetTokenAccountBalanceConfigToJson(GetTokenAccountBalanceConfig instance) =>
    <String, dynamic>{'commitment': ?_$CommitmentEnumMap[instance.commitment]};

Map<String, dynamic> _$GetTokenAccountsByDelegateConfigToJson(
  GetTokenAccountsByDelegateConfig instance,
) => <String, dynamic>{
  'commitment': _$CommitmentEnumMap[instance.commitment]!,
  'encoding': ?_$EncodingEnumMap[instance.encoding],
  'dataSlice': ?instance.dataSlice?.toJson(),
  'minContextSlot': ?instance.minContextSlot,
};

Map<String, dynamic> _$GetTokenAccountsByOwnerConfigToJson(
  GetTokenAccountsByOwnerConfig instance,
) => <String, dynamic>{
  'commitment': _$CommitmentEnumMap[instance.commitment]!,
  'encoding': ?_$EncodingEnumMap[instance.encoding],
  'dataSlice': ?instance.dataSlice?.toJson(),
  'minContextSlot': ?instance.minContextSlot,
};

Map<String, dynamic> _$GetTokenLargestAccountsConfigToJson(
  GetTokenLargestAccountsConfig instance,
) => <String, dynamic>{'commitment': ?_$CommitmentEnumMap[instance.commitment]};

Map<String, dynamic> _$GetTokenSupplyConfigToJson(GetTokenSupplyConfig instance) =>
    <String, dynamic>{'commitment': ?_$CommitmentEnumMap[instance.commitment]};

Map<String, dynamic> _$GetTransactionConfigToJson(GetTransactionConfig instance) =>
    <String, dynamic>{
      'encoding': ?_$EncodingEnumMap[instance.encoding],
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'maxSupportedTransactionVersion': ?instance.maxSupportedTransactionVersion,
    };

Map<String, dynamic> _$GetTransactionCountConfigToJson(GetTransactionCountConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'minContextSlot': ?instance.minContextSlot,
    };

Map<String, dynamic> _$GetVoteAccountsConfigToJson(GetVoteAccountsConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'votePubKey': ?instance.votePubKey,
      'keepUnstakedDelinquents': ?instance.keepUnstakedDelinquents,
      'delinquentSlotDistance': ?instance.delinquentSlotDistance,
    };

Map<String, dynamic> _$IsBlockhashValidConfigToJson(IsBlockhashValidConfig instance) =>
    <String, dynamic>{
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'minContextSlot': ?instance.minContextSlot,
    };

Map<String, dynamic> _$RequestAirdropConfigToJson(RequestAirdropConfig instance) =>
    <String, dynamic>{'commitment': ?_$CommitmentEnumMap[instance.commitment]};

Map<String, dynamic> _$SendTransactionConfigToJson(SendTransactionConfig instance) =>
    <String, dynamic>{
      'encoding': _$EncodingEnumMap[instance.encoding]!,
      'preflightCommitment': ?_$CommitmentEnumMap[instance.preflightCommitment],
      'skipPreflight': ?instance.skipPreflight,
      'maxRetries': ?instance.maxRetries,
      'minContextSlot': ?instance.minContextSlot,
    };

Map<String, dynamic> _$SimulateTransactionConfigToJson(SimulateTransactionConfig instance) =>
    <String, dynamic>{
      'sigVerify': ?instance.sigVerify,
      'encoding': _$EncodingEnumMap[instance.encoding]!,
      'commitment': ?_$CommitmentEnumMap[instance.commitment],
      'replaceRecentBlockhash': ?instance.replaceRecentBlockhash,
      'accounts': ?instance.accounts?.toJson(),
      'minContextSlot': ?instance.minContextSlot,
    };

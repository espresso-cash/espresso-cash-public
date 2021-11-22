// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GetAccountInfoConfigToJson(
        GetAccountInfoConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'encoding': _$EncodingEnumMap[instance.encoding],
      'dataSlice': instance.dataSlice,
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
};

Map<String, dynamic> _$GetBalanceConfigToJson(GetBalanceConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetBlockConfigToJson(GetBlockConfig instance) =>
    <String, dynamic>{
      'encoding': _$EncodingEnumMap[instance.encoding],
      'transactionDetails':
          _$TransactionDetailLevelEnumMap[instance.transactionDetails],
      'rewards': instance.rewards,
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

const _$TransactionDetailLevelEnumMap = {
  TransactionDetailLevel.none: 'none',
  TransactionDetailLevel.full: 'full',
  TransactionDetailLevel.signatures: 'signatures',
};

Map<String, dynamic> _$GetBlockHeightConfigToJson(
    GetBlockHeightConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetBlockProductionConfigToJson(
        GetBlockProductionConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'range': instance.range,
      'identity': instance.identity,
    };

Map<String, dynamic> _$GetBlocksConfigToJson(GetBlocksConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetBlocksWithLimitConfigToJson(
    GetBlocksWithLimitConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetEpochInfoConfigToJson(GetEpochInfoConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetFeeCalculatorForBlockhashConfigToJson(
    GetFeeCalculatorForBlockhashConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetFeesConfigToJson(GetFeesConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetInflationGovernorConfigToJson(
    GetInflationGovernorConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetLargestAccountsConfigToJson(
        GetLargestAccountsConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'filter': _$CirculationStatusEnumMap[instance.filter],
    };

const _$CirculationStatusEnumMap = {
  CirculationStatus.circulating: 'circulating',
  CirculationStatus.nonCirculating: 'nonCirculating',
};

Map<String, dynamic> _$GetLeaderScheduleConfigToJson(
        GetLeaderScheduleConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'identity': instance.identity,
    };

Map<String, dynamic> _$GetMinimumBalanceForRentExemptionConfigToJson(
    GetMinimumBalanceForRentExemptionConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetMultipleAccountsConfigToJson(
        GetMultipleAccountsConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'encoding': _$EncodingEnumMap[instance.encoding],
      'dataSlice': instance.dataSlice,
    };

Map<String, dynamic> _$GetProgramAccountsConfigToJson(
        GetProgramAccountsConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'encoding': _$EncodingEnumMap[instance.encoding],
      'dataSlice': instance.dataSlice,
      'filter': instance.filter,
    };

Map<String, dynamic> _$GetRecentBlockhashConfigToJson(
    GetRecentBlockhashConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetSignaturesForAddressConfigToJson(
        GetSignaturesForAddressConfig instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'before': instance.before,
      'until': instance.until,
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

Map<String, dynamic> _$GetSignatureStatusesConfigToJson(
        GetSignatureStatusesConfig instance) =>
    <String, dynamic>{
      'searchTransactionHistory': instance.searchTransactionHistory,
    };

Map<String, dynamic> _$GetSlotConfigToJson(GetSlotConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetSlotLeaderConfigToJson(GetSlotLeaderConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetStakeActivationConfigToJson(
        GetStakeActivationConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'epoch': instance.epoch,
    };

Map<String, dynamic> _$GetSupplyConfigToJson(GetSupplyConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'excludeNonCirculatingAccountsList':
          instance.excludeNonCirculatingAccountsList,
    };

Map<String, dynamic> _$GetTokenAccountBalanceConfigToJson(
    GetTokenAccountBalanceConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetTokenAccountsByDelegateConfigToJson(
        GetTokenAccountsByDelegateConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'encoding': _$EncodingEnumMap[instance.encoding],
      'dataSlice': instance.dataSlice,
    };

Map<String, dynamic> _$GetTokenAccountsByOwnerConfigToJson(
        GetTokenAccountsByOwnerConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'encoding': _$EncodingEnumMap[instance.encoding],
      'dataSlice': instance.dataSlice,
    };

Map<String, dynamic> _$GetTokenLargestAccountsConfigToJson(
    GetTokenLargestAccountsConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetTokenSupplyConfigToJson(
    GetTokenSupplyConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetTransactionConfigToJson(
        GetTransactionConfig instance) =>
    <String, dynamic>{
      'encoding': _$EncodingEnumMap[instance.encoding],
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

Map<String, dynamic> _$GetTransactionCountConfigToJson(
    GetTransactionCountConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetVoteAccountsConfigToJson(
        GetVoteAccountsConfig instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'votePubKey': instance.votePubKey,
      'keepUnstakedDelinquents': instance.keepUnstakedDelinquents,
      'delinquentSlotDistance': instance.delinquentSlotDistance,
    };

Map<String, dynamic> _$RequestAirdropConfigToJson(
    RequestAirdropConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$SendTransactionConfigToJson(
        SendTransactionConfig instance) =>
    <String, dynamic>{
      'encoding': _$EncodingEnumMap[instance.encoding],
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'skipPreflight': instance.skipPreflight,
      'maxRetries': instance.maxRetries,
    };

Map<String, dynamic> _$SimulateTransactionConfigToJson(
        SimulateTransactionConfig instance) =>
    <String, dynamic>{
      'sigVerify': instance.sigVerify,
      'encoding': _$EncodingEnumMap[instance.encoding],
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'replaceRecentBlockhash': instance.replaceRecentBlockhash,
      'accounts': instance.accounts,
    };

Map<String, dynamic> _$GetConfirmedBlockConfigToJson(
        GetConfirmedBlockConfig instance) =>
    <String, dynamic>{
      'encoding': _$EncodingEnumMap[instance.encoding],
      'transactionDetails':
          _$TransactionDetailLevelEnumMap[instance.transactionDetails],
      'rewards': instance.rewards,
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

Map<String, dynamic> _$GetConfirmedSignaturesForAddress2ConfigToJson(
        GetConfirmedSignaturesForAddress2Config instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'before': instance.before,
      'until': instance.until,
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

Map<String, dynamic> _$GetConfirmedTransactionConfigToJson(
        GetConfirmedTransactionConfig instance) =>
    <String, dynamic>{
      'encoding': _$EncodingEnumMap[instance.encoding],
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GetAccountInfoConfigToJson(
    GetAccountInfoConfig instance) {
  final val = <String, dynamic>{
    'commitment': _$CommitmentEnumMap[instance.commitment]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('dataSlice', instance.dataSlice?.toJson());
  return val;
}

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

Map<String, dynamic> _$GetBlockConfigToJson(GetBlockConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('transactionDetails',
      _$TransactionDetailLevelEnumMap[instance.transactionDetails]);
  writeNotNull('rewards', instance.rewards);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

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
    GetBlockProductionConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('range', instance.range?.toJson());
  writeNotNull('identity', instance.identity);
  return val;
}

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
    GetLargestAccountsConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('filter', _$CirculationStatusEnumMap[instance.filter]);
  return val;
}

const _$CirculationStatusEnumMap = {
  CirculationStatus.circulating: 'circulating',
  CirculationStatus.nonCirculating: 'nonCirculating',
};

Map<String, dynamic> _$GetLeaderScheduleConfigToJson(
    GetLeaderScheduleConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('identity', instance.identity);
  return val;
}

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
    GetMultipleAccountsConfig instance) {
  final val = <String, dynamic>{
    'commitment': _$CommitmentEnumMap[instance.commitment]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('dataSlice', instance.dataSlice?.toJson());
  return val;
}

Map<String, dynamic> _$GetProgramAccountsConfigToJson(
    GetProgramAccountsConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  val['encoding'] = _$EncodingEnumMap[instance.encoding]!;
  writeNotNull('dataSlice', instance.dataSlice?.toJson());
  writeNotNull('filters', instance.filters?.map((e) => e.toJson()).toList());
  return val;
}

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
    GetSignaturesForAddressConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('limit', instance.limit);
  writeNotNull('before', instance.before);
  writeNotNull('until', instance.until);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetSignatureStatusesConfigToJson(
    GetSignatureStatusesConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('searchTransactionHistory', instance.searchTransactionHistory);
  return val;
}

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
    GetStakeActivationConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('epoch', instance.epoch);
  return val;
}

Map<String, dynamic> _$GetSupplyConfigToJson(GetSupplyConfig instance) {
  final val = <String, dynamic>{
    'commitment': _$CommitmentEnumMap[instance.commitment]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('excludeNonCirculatingAccountsList',
      instance.excludeNonCirculatingAccountsList);
  return val;
}

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
    GetTokenAccountsByDelegateConfig instance) {
  final val = <String, dynamic>{
    'commitment': _$CommitmentEnumMap[instance.commitment]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('dataSlice', instance.dataSlice?.toJson());
  return val;
}

Map<String, dynamic> _$GetTokenAccountsByOwnerConfigToJson(
    GetTokenAccountsByOwnerConfig instance) {
  final val = <String, dynamic>{
    'commitment': _$CommitmentEnumMap[instance.commitment]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('dataSlice', instance.dataSlice?.toJson());
  return val;
}

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
    GetTransactionConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

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
    GetVoteAccountsConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('votePubKey', instance.votePubKey);
  writeNotNull('keepUnstakedDelinquents', instance.keepUnstakedDelinquents);
  writeNotNull('delinquentSlotDistance', instance.delinquentSlotDistance);
  return val;
}

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
    SendTransactionConfig instance) {
  final val = <String, dynamic>{
    'encoding': _$EncodingEnumMap[instance.encoding]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'preflightCommitment', _$CommitmentEnumMap[instance.preflightCommitment]);
  writeNotNull('skipPreflight', instance.skipPreflight);
  writeNotNull('maxRetries', instance.maxRetries);
  return val;
}

Map<String, dynamic> _$SimulateTransactionConfigToJson(
    SimulateTransactionConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sigVerify', instance.sigVerify);
  val['encoding'] = _$EncodingEnumMap[instance.encoding]!;
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('replaceRecentBlockhash', instance.replaceRecentBlockhash);
  writeNotNull('accounts', instance.accounts?.toJson());
  return val;
}

Map<String, dynamic> _$GetConfirmedBlockConfigToJson(
    GetConfirmedBlockConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('transactionDetails',
      _$TransactionDetailLevelEnumMap[instance.transactionDetails]);
  writeNotNull('rewards', instance.rewards);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetConfirmedSignaturesForAddress2ConfigToJson(
    GetConfirmedSignaturesForAddress2Config instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('limit', instance.limit);
  writeNotNull('before', instance.before);
  writeNotNull('until', instance.until);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Map<String, dynamic> _$GetConfirmedTransactionConfigToJson(
    GetConfirmedTransactionConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

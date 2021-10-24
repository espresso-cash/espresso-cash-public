// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GetConfirmedTransactionOptionsToJson(
    GetConfirmedTransactionOptions instance) {
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

const _$EncodingEnumMap = {
  Encoding.base64: 'base64',
  Encoding.jsonParsed: 'jsonParsed',
};

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};

Map<String, dynamic> _$SimulateTransactionAccountsToJson(
    SimulateTransactionAccounts instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('accountEncoding', _$EncodingEnumMap[instance.accountEncoding]);
  writeNotNull('addresses', instance.addresses);
  return val;
}

Map<String, dynamic> _$SimulateTransactionOptionsToJson(
    SimulateTransactionOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sigVerify', instance.sigVerify);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('replaceRecentBlockhash', instance.replaceRecentBlockhash);
  writeNotNull('accounts', instance.accounts);
  val['encoding'] = instance.encoding;
  return val;
}

Map<String, dynamic> _$SendTransactionOptionsToJson(
    SendTransactionOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('skipPreflight', instance.skipPreflight);
  writeNotNull('maxRetries', instance.maxRetries);
  val['encoding'] = instance.encoding;
  return val;
}

Map<String, dynamic> _$GetVoteAccountsOptionsToJson(
    GetVoteAccountsOptions instance) {
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

Map<String, dynamic> _$GetTransactionOptionsToJson(
    GetTransactionOptions instance) {
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

Map<String, dynamic> _$GetSupplyOptionsToJson(GetSupplyOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('excludeNonCirculatingAccountsList',
      instance.excludeNonCirculatingAccountsList);
  return val;
}

Map<String, dynamic> _$GetStakeActivationOptionsToJson(
    GetStakeActivationOptions instance) {
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

Map<String, dynamic> _$GetSignatureStatusesOptionsToJson(
    GetSignatureStatusesOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('searchTransactionHistory', instance.searchTransactionHistory);
  return val;
}

Map<String, dynamic> _$GetSignaturesForAddressOptionsToJson(
    GetSignaturesForAddressOptions instance) {
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

Map<String, dynamic> _$GetProgramAccountsOptionsToJson(
    GetProgramAccountsOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('dataSlice', instance.dataSlice);
  writeNotNull('filter', instance.filter);
  return val;
}

Map<String, dynamic> _$GetLeaderScheduleOptionsToJson(
    GetLeaderScheduleOptions instance) {
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

Map<String, dynamic> _$GetLargestAccountsOptionsToJson(
    GetLargestAccountsOptions instance) {
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

Map<String, dynamic> _$GetBlockProductionOptionsToJson(
    GetBlockProductionOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('range', instance.range);
  writeNotNull('identity', instance.identity);
  return val;
}

Map<String, dynamic> _$GetBlockOptionsToJson(GetBlockOptions instance) {
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

Map<String, dynamic> _$GetAccountInfoOptionsToJson(
    GetAccountInfoOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('encoding', _$EncodingEnumMap[instance.encoding]);
  writeNotNull('dataSlice', instance.dataSlice);
  return val;
}

Map<String, dynamic> _$MintOrProgramIdToJson(MintOrProgramId instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mint', instance.mint);
  writeNotNull('programId', instance.programId);
  return val;
}

Map<String, dynamic> _$DataSliceToJson(DataSlice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offset', instance.offset);
  writeNotNull('length', instance.length);
  return val;
}

Map<String, dynamic> _$CommitmentObjectToJson(CommitmentObject instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{
    'lamports': instance.lamports,
    'owner': instance.owner,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', const AccountDataConverter().toJson(instance.data));
  val['executable'] = instance.executable;
  val['rentEpoch'] = instance.rentEpoch;
  return val;
}

Map<String, dynamic> _$BlockToJson(Block instance) {
  final val = <String, dynamic>{
    'blockhash': instance.blockhash,
    'previousBlockhash': instance.previousBlockhash,
    'parentSlot': instance.parentSlot,
    'transactions': instance.transactions,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('meta', instance.meta);
  val['signatures'] = instance.signatures;
  val['rewards'] = instance.rewards;
  writeNotNull('blockTime', instance.blockTime);
  writeNotNull('blockHeight', instance.blockHeight);
  return val;
}

Map<String, dynamic> _$MetaToJson(Meta instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('err', instance.err);
  val['fee'] = instance.fee;
  val['preBalances'] = instance.preBalances;
  val['postBalances'] = instance.postBalances;
  val['innerInstructions'] = instance.innerInstructions;
  val['preTokenBalances'] = instance.preTokenBalances;
  val['postTokenBalances'] = instance.postTokenBalances;
  val['logMessages'] = instance.logMessages;
  return val;
}

Map<String, dynamic> _$RewardToJson(Reward instance) => <String, dynamic>{
      'pubkey': instance.pubkey,
      'lamports': instance.lamports,
      'postBalance': instance.postBalance,
      'rewardType': _$RewardTypeEnumMap[instance.rewardType],
      'commission': instance.commission,
    };

const _$RewardTypeEnumMap = {
  RewardType.fee: 'fee',
  RewardType.rent: 'rent',
  RewardType.staking: 'staking',
  RewardType.voting: 'voting',
};

Map<String, dynamic> _$TransactionMessageHeaderToJson(
        TransactionMessageHeader instance) =>
    <String, dynamic>{
      'numRequiredSignatures': instance.numRequiredSignatures,
      'numReadonlySignedAccounts': instance.numReadonlySignedAccounts,
      'numReadonlyUnsignedAccounts': instance.numReadonlyUnsignedAccounts,
    };

Map<String, dynamic> _$TransactionMessageToJson(TransactionMessage instance) =>
    <String, dynamic>{
      'accountKeys': instance.accountKeys,
      'header': instance.header,
      'recentBlockhash': instance.recentBlockhash,
      'instructions': instance.instructions,
    };

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'signatures': instance.signatures,
      'message': instance.message,
    };

Map<String, dynamic> _$TransactionDetailsToJson(TransactionDetails instance) {
  final val = <String, dynamic>{
    'slot': instance.slot,
    'transaction': instance.transaction,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('blockTime', instance.blockTime);
  val['meta'] = instance.meta;
  return val;
}

Map<String, dynamic> _$InnerInstructionToJson(InnerInstruction instance) =>
    <String, dynamic>{
      'index': instance.index,
      'instruction': instance.instruction,
    };

Map<String, dynamic> _$InstructionToJson(Instruction instance) =>
    <String, dynamic>{
      'programIdIndex': instance.programIdIndex,
      'accounts': instance.accounts,
      'data': instance.data,
    };

Map<String, dynamic> _$TokenAmountToJson(TokenAmount instance) {
  final val = <String, dynamic>{
    'amount': instance.amount,
    'decimals': instance.decimals,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uiAmountString', instance.uiAmountString);
  return val;
}

Map<String, dynamic> _$TokenBalanceToJson(TokenBalance instance) =>
    <String, dynamic>{
      'accountIndex': instance.accountIndex,
      'mint': instance.mint,
      'uiTokenAmount': instance.uiTokenAmount,
    };

Map<String, dynamic> _$ClusterNodeToJson(ClusterNode instance) {
  final val = <String, dynamic>{
    'pubkey': instance.pubkey,
    'gossip': instance.gossip,
    'tpu': instance.tpu,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rpc', instance.rpc);
  writeNotNull('version', instance.version);
  writeNotNull('featureSet', instance.featureSet);
  writeNotNull('shredVersion', instance.shredVersion);
  return val;
}

Map<String, dynamic> _$EpochInfoToJson(EpochInfo instance) => <String, dynamic>{
      'absoluteSlot': instance.absoluteSlot,
      'blockHeight': instance.blockHeight,
      'epoch': instance.epoch,
      'slotIndex': instance.slotIndex,
      'slotsInEpoch': instance.slotsInEpoch,
    };

Map<String, dynamic> _$FeeCalculatorToJson(FeeCalculator instance) =>
    <String, dynamic>{
      'lamportsPerSignature': instance.lamportsPerSignature,
    };

Map<String, dynamic> _$RangeToJson(Range instance) => <String, dynamic>{
      'firstSlot': instance.firstSlot,
      'lastSlot': instance.lastSlot,
    };

Map<String, dynamic> _$BlockProductionToJson(BlockProduction instance) =>
    <String, dynamic>{
      'byIdentity': instance.byIdentity,
      'range': instance.range,
    };

Map<String, dynamic> _$BlockCommitmentToJson(BlockCommitment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', instance.commitment);
  val['totalStake'] = instance.totalStake;
  return val;
}

Map<String, dynamic> _$EpochScheduleToJson(EpochSchedule instance) =>
    <String, dynamic>{
      'slotsPerEpoch': instance.slotsPerEpoch,
      'leaderScheduleSlotOffset': instance.leaderScheduleSlotOffset,
      'warmup': instance.warmup,
      'firstNormalEpoch': instance.firstNormalEpoch,
      'firstNormalSlot': instance.firstNormalSlot,
    };

Map<String, dynamic> _$FeeRateGovernorValueToJson(
        FeeRateGovernorValue instance) =>
    <String, dynamic>{
      'burnPercent': instance.burnPercent,
      'maxLamportsPerSignature': instance.maxLamportsPerSignature,
      'minLamportsPerSignature': instance.minLamportsPerSignature,
      'targetLamportsPerSignature': instance.targetLamportsPerSignature,
      'targetSignaturesPerSlot': instance.targetSignaturesPerSlot,
    };

Map<String, dynamic> _$FeeRateGovernorToJson(FeeRateGovernor instance) =>
    <String, dynamic>{
      'feeRateGovernor': instance.feeRateGovernor,
    };

Map<String, dynamic> _$FeesToJson(Fees instance) => <String, dynamic>{
      'blockhash': instance.blockhash,
      'feeCalculator': instance.feeCalculator,
      'lastValidBlockHeight': instance.lastValidBlockHeight,
    };

Map<String, dynamic> _$IdentityToJson(Identity instance) => <String, dynamic>{
      'identity': instance.identity,
    };

Map<String, dynamic> _$InflationGovernorToJson(InflationGovernor instance) =>
    <String, dynamic>{
      'initial': instance.initial,
      'terminal': instance.terminal,
      'taper': instance.taper,
      'foundation': instance.foundation,
      'foundationTerm': instance.foundationTerm,
    };

Map<String, dynamic> _$InflationRateToJson(InflationRate instance) =>
    <String, dynamic>{
      'total': instance.total,
      'validator': instance.validator,
      'foundation': instance.foundation,
      'epoch': instance.epoch,
    };

Map<String, dynamic> _$InflationRewardToJson(InflationReward instance) =>
    <String, dynamic>{
      'epoch': instance.epoch,
      'effectiveSlot': instance.effectiveSlot,
      'amount': instance.amount,
      'postBalance': instance.postBalance,
      'commission': instance.commission,
    };

Map<String, dynamic> _$LargeAccountToJson(LargeAccount instance) =>
    <String, dynamic>{
      'address': instance.address,
      'lamports': instance.lamports,
    };

Map<String, dynamic> _$FilterParamsToJson(FilterParams instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'bytes': instance.bytes,
    };

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'memcmp': instance.memcmp,
      'dataSize': instance.dataSize,
    };

Map<String, dynamic> _$ProgramAccountToJson(ProgramAccount instance) =>
    <String, dynamic>{
      'account': instance.account,
      'pubkey': instance.pubkey,
    };

Map<String, dynamic> _$RecentBlockhashToJson(RecentBlockhash instance) =>
    <String, dynamic>{
      'blockhash': instance.blockhash,
      'feeCalculator': instance.feeCalculator,
    };

Map<String, dynamic> _$PerfSampleToJson(PerfSample instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'numTransactions': instance.numTransactions,
      'numSlots': instance.numSlots,
      'samplePeriodSec': instance.samplePeriodSec,
    };

Map<String, dynamic> _$TransactionSignatureInformationToJson(
    TransactionSignatureInformation instance) {
  final val = <String, dynamic>{
    'signature': instance.signature,
    'slot': instance.slot,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('err', instance.err);
  writeNotNull('memo', instance.memo);
  writeNotNull('blockTime', instance.blockTime);
  return val;
}

Map<String, dynamic> _$SignatureStatusToJson(SignatureStatus instance) {
  final val = <String, dynamic>{
    'slot': instance.slot,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('confirmations', instance.confirmations);
  writeNotNull('err', instance.err);
  val['confirmationStatus'] = _$CommitmentEnumMap[instance.confirmationStatus];
  return val;
}

Map<String, dynamic> _$StakeActivationToJson(StakeActivation instance) =>
    <String, dynamic>{
      'state': _$StakeActivationStateEnumMap[instance.state],
      'active': instance.active,
      'inactive': instance.inactive,
    };

const _$StakeActivationStateEnumMap = {
  StakeActivationState.activating: 'activating',
  StakeActivationState.active: 'active',
  StakeActivationState.deactivating: 'deactivating',
  StakeActivationState.inactive: 'inactive',
};

Map<String, dynamic> _$SupplyToJson(Supply instance) => <String, dynamic>{
      'total': instance.total,
      'circulating': instance.circulating,
      'nonCirculating': instance.nonCirculating,
      'nonCirculatingAccounts': instance.nonCirculatingAccounts,
    };

Map<String, dynamic> _$SolanaVersionToJson(SolanaVersion instance) =>
    <String, dynamic>{
      'solana-core': instance.solanaCore,
      'feature-set': instance.featureSet,
    };

Map<String, dynamic> _$VoteAccountsToJson(VoteAccounts instance) =>
    <String, dynamic>{
      'votePubkey': instance.votePubkey,
      'nodePubkey': instance.nodePubkey,
      'activatedStake': instance.activatedStake,
      'epochVoteAccount': instance.epochVoteAccount,
      'commission': instance.commission,
      'lastVote': instance.lastVote,
      'epochCredits': instance.epochCredits,
    };

Map<String, dynamic> _$TransactionStatusToJson(TransactionStatus instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('err', instance.err);
  writeNotNull('logs', instance.logs);
  writeNotNull('accounts', instance.accounts);
  return val;
}

_$_GetConfirmedTransactionOptions _$$_GetConfirmedTransactionOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetConfirmedTransactionOptions(
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

Map<String, dynamic> _$$_GetConfirmedTransactionOptionsToJson(
        _$_GetConfirmedTransactionOptions instance) =>
    <String, dynamic>{
      'encoding': _$EncodingEnumMap[instance.encoding],
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

_$_SimulateTransactionAccounts _$$_SimulateTransactionAccountsFromJson(
        Map<String, dynamic> json) =>
    _$_SimulateTransactionAccounts(
      accountEncoding:
          _$enumDecodeNullable(_$EncodingEnumMap, json['accountEncoding']),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_SimulateTransactionAccountsToJson(
        _$_SimulateTransactionAccounts instance) =>
    <String, dynamic>{
      'accountEncoding': _$EncodingEnumMap[instance.accountEncoding],
      'addresses': instance.addresses,
    };

_$_SimulateTransactionOptions _$$_SimulateTransactionOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_SimulateTransactionOptions(
      sigVerify: json['sigVerify'] as bool?,
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      replaceRecentBlockhash: json['replaceRecentBlockhash'] as bool?,
      accounts: json['accounts'] == null
          ? null
          : SimulateTransactionAccounts.fromJson(
              json['accounts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SimulateTransactionOptionsToJson(
        _$_SimulateTransactionOptions instance) =>
    <String, dynamic>{
      'sigVerify': instance.sigVerify,
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'replaceRecentBlockhash': instance.replaceRecentBlockhash,
      'accounts': instance.accounts,
    };

_$_SendTransactionOptions _$$_SendTransactionOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_SendTransactionOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      skipPreflight: json['skipPreflight'] as bool?,
      maxRetries: json['maxRetries'] as int?,
    );

Map<String, dynamic> _$$_SendTransactionOptionsToJson(
        _$_SendTransactionOptions instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'skipPreflight': instance.skipPreflight,
      'maxRetries': instance.maxRetries,
    };

_$_GetVoteAccountsOptions _$$_GetVoteAccountsOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetVoteAccountsOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      votePubKey: json['votePubKey'] as String?,
      keepUnstakedDelinquents: json['keepUnstakedDelinquents'] as bool?,
      delinquentSlotDistance: json['delinquentSlotDistance'] as int?,
    );

Map<String, dynamic> _$$_GetVoteAccountsOptionsToJson(
        _$_GetVoteAccountsOptions instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'votePubKey': instance.votePubKey,
      'keepUnstakedDelinquents': instance.keepUnstakedDelinquents,
      'delinquentSlotDistance': instance.delinquentSlotDistance,
    };

_$_GetTransactionOptions _$$_GetTransactionOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetTransactionOptions(
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

Map<String, dynamic> _$$_GetTransactionOptionsToJson(
        _$_GetTransactionOptions instance) =>
    <String, dynamic>{
      'encoding': _$EncodingEnumMap[instance.encoding],
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

_$_GetSupplyOptions _$$_GetSupplyOptionsFromJson(Map<String, dynamic> json) =>
    _$_GetSupplyOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      excludeNonCirculatingAccountsList:
          json['excludeNonCirculatingAccountsList'] as bool?,
    );

Map<String, dynamic> _$$_GetSupplyOptionsToJson(_$_GetSupplyOptions instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'excludeNonCirculatingAccountsList':
          instance.excludeNonCirculatingAccountsList,
    };

_$_GetStakeActivationOptions _$$_GetStakeActivationOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetStakeActivationOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      epoch: json['epoch'] as int?,
    );

Map<String, dynamic> _$$_GetStakeActivationOptionsToJson(
        _$_GetStakeActivationOptions instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'epoch': instance.epoch,
    };

_$_GetSignatureStatusesOptions _$$_GetSignatureStatusesOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetSignatureStatusesOptions(
      searchTransactionHistory: json['searchTransactionHistory'] as bool?,
    );

Map<String, dynamic> _$$_GetSignatureStatusesOptionsToJson(
        _$_GetSignatureStatusesOptions instance) =>
    <String, dynamic>{
      'searchTransactionHistory': instance.searchTransactionHistory,
    };

_$_GetSignaturesForAddressOptions _$$_GetSignaturesForAddressOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetSignaturesForAddressOptions(
      limit: json['limit'] as int?,
      before: json['before'] as String?,
      until: json['until'] as String?,
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

Map<String, dynamic> _$$_GetSignaturesForAddressOptionsToJson(
        _$_GetSignaturesForAddressOptions instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'before': instance.before,
      'until': instance.until,
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

_$_GetProgramAccountsOptions _$$_GetProgramAccountsOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetProgramAccountsOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      dataSlice: json['dataSlice'] == null
          ? null
          : DataSlice.fromJson(json['dataSlice'] as Map<String, dynamic>),
      filter: (json['filter'] as List<dynamic>?)
          ?.map((e) => Filter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GetProgramAccountsOptionsToJson(
        _$_GetProgramAccountsOptions instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'encoding': _$EncodingEnumMap[instance.encoding],
      'dataSlice': instance.dataSlice,
      'filter': instance.filter,
    };

_$_GetLeaderScheduleOptions _$$_GetLeaderScheduleOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetLeaderScheduleOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      identity: json['identity'] as String?,
    );

Map<String, dynamic> _$$_GetLeaderScheduleOptionsToJson(
        _$_GetLeaderScheduleOptions instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'identity': instance.identity,
    };

_$_GetLargestAccountsOptions _$$_GetLargestAccountsOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetLargestAccountsOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      filter: _$enumDecodeNullable(_$CirculationStatusEnumMap, json['filter']),
    );

Map<String, dynamic> _$$_GetLargestAccountsOptionsToJson(
        _$_GetLargestAccountsOptions instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'filter': _$CirculationStatusEnumMap[instance.filter],
    };

_$_GetBlockProductionOptions _$$_GetBlockProductionOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetBlockProductionOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      range: json['range'] == null
          ? null
          : Range.fromJson(json['range'] as Map<String, dynamic>),
      identity: json['identity'] as String?,
    );

Map<String, dynamic> _$$_GetBlockProductionOptionsToJson(
        _$_GetBlockProductionOptions instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'range': instance.range,
      'identity': instance.identity,
    };

_$_GetBlockOptions _$$_GetBlockOptionsFromJson(Map<String, dynamic> json) =>
    _$_GetBlockOptions(
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      transactionDetails: _$enumDecodeNullable(
          _$TransactionDetailLevelEnumMap, json['transactionDetails']),
      rewards: json['rewards'] as bool?,
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

Map<String, dynamic> _$$_GetBlockOptionsToJson(_$_GetBlockOptions instance) =>
    <String, dynamic>{
      'encoding': _$EncodingEnumMap[instance.encoding],
      'transactionDetails':
          _$TransactionDetailLevelEnumMap[instance.transactionDetails],
      'rewards': instance.rewards,
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

_$_GetAccountInfoOptions _$$_GetAccountInfoOptionsFromJson(
        Map<String, dynamic> json) =>
    _$_GetAccountInfoOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      dataSlice: json['dataSlice'] == null
          ? null
          : DataSlice.fromJson(json['dataSlice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GetAccountInfoOptionsToJson(
        _$_GetAccountInfoOptions instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
      'encoding': _$EncodingEnumMap[instance.encoding],
      'dataSlice': instance.dataSlice,
    };

_$_MintOrProgramId _$$_MintOrProgramIdFromJson(Map<String, dynamic> json) =>
    _$_MintOrProgramId(
      mint: json['mint'] as String?,
      programId: json['programId'] as String?,
    );

Map<String, dynamic> _$$_MintOrProgramIdToJson(_$_MintOrProgramId instance) =>
    <String, dynamic>{
      'mint': instance.mint,
      'programId': instance.programId,
    };

_$_DataSlice _$$_DataSliceFromJson(Map<String, dynamic> json) => _$_DataSlice(
      offset: json['offset'] as int?,
      length: json['length'] as int?,
    );

Map<String, dynamic> _$$_DataSliceToJson(_$_DataSlice instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'length': instance.length,
    };

_$_CommitmentObject _$$_CommitmentObjectFromJson(Map<String, dynamic> json) =>
    _$_CommitmentObject(
      commitment: _$enumDecode(_$CommitmentEnumMap, json['commitment']),
    );

Map<String, dynamic> _$$_CommitmentObjectToJson(_$_CommitmentObject instance) =>
    <String, dynamic>{
      'commitment': _$CommitmentEnumMap[instance.commitment],
    };

_$_Account _$$_AccountFromJson(Map<String, dynamic> json) => _$_Account(
      lamports: json['lamports'] as int,
      owner: json['owner'] as String,
      data: const AccountDataConverter().fromJson(json['data']),
      executable: json['executable'] as bool,
      rentEpoch: json['rentEpoch'] as int,
    );

Map<String, dynamic> _$$_AccountToJson(_$_Account instance) =>
    <String, dynamic>{
      'lamports': instance.lamports,
      'owner': instance.owner,
      'data': const AccountDataConverter().toJson(instance.data),
      'executable': instance.executable,
      'rentEpoch': instance.rentEpoch,
    };

_$_Block _$$_BlockFromJson(Map<String, dynamic> json) => _$_Block(
      blockhash: json['blockhash'] as String,
      previousBlockhash: json['previousBlockhash'] as String,
      parentSlot: json['parentSlot'] as int,
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      signatures: (json['signatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      rewards: (json['rewards'] as List<dynamic>)
          .map((e) => Reward.fromJson(e as Map<String, dynamic>))
          .toList(),
      blockTime: json['blockTime'] as int?,
      blockHeight: json['blockHeight'] as int?,
    );

Map<String, dynamic> _$$_BlockToJson(_$_Block instance) => <String, dynamic>{
      'blockhash': instance.blockhash,
      'previousBlockhash': instance.previousBlockhash,
      'parentSlot': instance.parentSlot,
      'transactions': instance.transactions,
      'meta': instance.meta,
      'signatures': instance.signatures,
      'rewards': instance.rewards,
      'blockTime': instance.blockTime,
      'blockHeight': instance.blockHeight,
    };

_$_Meta _$$_MetaFromJson(Map<String, dynamic> json) => _$_Meta(
      err: json['err'] as Map<String, dynamic>?,
      fee: json['fee'] as int,
      preBalances:
          (json['preBalances'] as List<dynamic>).map((e) => e as int).toList(),
      postBalances:
          (json['postBalances'] as List<dynamic>).map((e) => e as int).toList(),
      innerInstructions: (json['innerInstructions'] as List<dynamic>)
          .map((e) => InnerInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      preTokenBalances: (json['preTokenBalances'] as List<dynamic>)
          .map((e) => TokenBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
      postTokenBalances: (json['postTokenBalances'] as List<dynamic>)
          .map((e) => TokenBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
      logMessages: (json['logMessages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_MetaToJson(_$_Meta instance) => <String, dynamic>{
      'err': instance.err,
      'fee': instance.fee,
      'preBalances': instance.preBalances,
      'postBalances': instance.postBalances,
      'innerInstructions': instance.innerInstructions,
      'preTokenBalances': instance.preTokenBalances,
      'postTokenBalances': instance.postTokenBalances,
      'logMessages': instance.logMessages,
    };

_$_Reward _$$_RewardFromJson(Map<String, dynamic> json) => _$_Reward(
      pubkey: json['pubkey'] as String,
      lamports: json['lamports'] as int,
      postBalance: json['postBalance'] as int,
      rewardType: _$enumDecode(_$RewardTypeEnumMap, json['rewardType']),
      commission: json['commission'] as int,
    );

Map<String, dynamic> _$$_RewardToJson(_$_Reward instance) => <String, dynamic>{
      'pubkey': instance.pubkey,
      'lamports': instance.lamports,
      'postBalance': instance.postBalance,
      'rewardType': _$RewardTypeEnumMap[instance.rewardType],
      'commission': instance.commission,
    };

_$_TransactionMessageHeader _$$_TransactionMessageHeaderFromJson(
        Map<String, dynamic> json) =>
    _$_TransactionMessageHeader(
      numRequiredSignatures: json['numRequiredSignatures'] as int,
      numReadonlySignedAccounts: json['numReadonlySignedAccounts'] as int,
      numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'] as int,
    );

Map<String, dynamic> _$$_TransactionMessageHeaderToJson(
        _$_TransactionMessageHeader instance) =>
    <String, dynamic>{
      'numRequiredSignatures': instance.numRequiredSignatures,
      'numReadonlySignedAccounts': instance.numReadonlySignedAccounts,
      'numReadonlyUnsignedAccounts': instance.numReadonlyUnsignedAccounts,
    };

_$_TransactionMessage _$$_TransactionMessageFromJson(
        Map<String, dynamic> json) =>
    _$_TransactionMessage(
      accountKeys: (json['accountKeys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      header: TransactionMessageHeader.fromJson(
          json['header'] as Map<String, dynamic>),
      recentBlockhash: json['recentBlockhash'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TransactionMessageToJson(
        _$_TransactionMessage instance) =>
    <String, dynamic>{
      'accountKeys': instance.accountKeys,
      'header': instance.header,
      'recentBlockhash': instance.recentBlockhash,
      'instructions': instance.instructions,
    };

_$_Transaction _$$_TransactionFromJson(Map<String, dynamic> json) =>
    _$_Transaction(
      signatures: (json['signatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      message:
          TransactionMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TransactionToJson(_$_Transaction instance) =>
    <String, dynamic>{
      'signatures': instance.signatures,
      'message': instance.message,
    };

_$_TransactionDetails _$$_TransactionDetailsFromJson(
        Map<String, dynamic> json) =>
    _$_TransactionDetails(
      slot: json['slot'] as int,
      transaction:
          Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
      blockTime: json['blockTime'] as int?,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TransactionDetailsToJson(
        _$_TransactionDetails instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'transaction': instance.transaction,
      'blockTime': instance.blockTime,
      'meta': instance.meta,
    };

_$_InnerInstruction _$$_InnerInstructionFromJson(Map<String, dynamic> json) =>
    _$_InnerInstruction(
      index: json['index'] as int,
      instruction: (json['instruction'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_InnerInstructionToJson(_$_InnerInstruction instance) =>
    <String, dynamic>{
      'index': instance.index,
      'instruction': instance.instruction,
    };

_$_Instruction _$$_InstructionFromJson(Map<String, dynamic> json) =>
    _$_Instruction(
      programIdIndex: json['programIdIndex'] as int,
      accounts:
          (json['accounts'] as List<dynamic>).map((e) => e as int).toList(),
      data: json['data'] as String,
    );

Map<String, dynamic> _$$_InstructionToJson(_$_Instruction instance) =>
    <String, dynamic>{
      'programIdIndex': instance.programIdIndex,
      'accounts': instance.accounts,
      'data': instance.data,
    };

_$_TokenAmount _$$_TokenAmountFromJson(Map<String, dynamic> json) =>
    _$_TokenAmount(
      amount: json['amount'] as String,
      decimals: json['decimals'] as int,
      uiAmountString: json['uiAmountString'] as String?,
    );

Map<String, dynamic> _$$_TokenAmountToJson(_$_TokenAmount instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'decimals': instance.decimals,
      'uiAmountString': instance.uiAmountString,
    };

_$_TokenBalance _$$_TokenBalanceFromJson(Map<String, dynamic> json) =>
    _$_TokenBalance(
      accountIndex: json['accountIndex'] as int,
      mint: json['mint'] as String,
      uiTokenAmount:
          TokenAmount.fromJson(json['uiTokenAmount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TokenBalanceToJson(_$_TokenBalance instance) =>
    <String, dynamic>{
      'accountIndex': instance.accountIndex,
      'mint': instance.mint,
      'uiTokenAmount': instance.uiTokenAmount,
    };

_$_ClusterNode _$$_ClusterNodeFromJson(Map<String, dynamic> json) =>
    _$_ClusterNode(
      pubkey: json['pubkey'] as String,
      gossip: json['gossip'] as String,
      tpu: json['tpu'] as String,
      rpc: json['rpc'] as String?,
      version: json['version'] as String?,
      featureSet: json['featureSet'] as int?,
      shredVersion: json['shredVersion'] as int?,
    );

Map<String, dynamic> _$$_ClusterNodeToJson(_$_ClusterNode instance) =>
    <String, dynamic>{
      'pubkey': instance.pubkey,
      'gossip': instance.gossip,
      'tpu': instance.tpu,
      'rpc': instance.rpc,
      'version': instance.version,
      'featureSet': instance.featureSet,
      'shredVersion': instance.shredVersion,
    };

_$_EpochInfo _$$_EpochInfoFromJson(Map<String, dynamic> json) => _$_EpochInfo(
      absoluteSlot: json['absoluteSlot'] as int,
      blockHeight: json['blockHeight'] as int,
      epoch: json['epoch'] as int,
      slotIndex: json['slotIndex'] as int,
      slotsInEpoch: json['slotsInEpoch'] as int,
    );

Map<String, dynamic> _$$_EpochInfoToJson(_$_EpochInfo instance) =>
    <String, dynamic>{
      'absoluteSlot': instance.absoluteSlot,
      'blockHeight': instance.blockHeight,
      'epoch': instance.epoch,
      'slotIndex': instance.slotIndex,
      'slotsInEpoch': instance.slotsInEpoch,
    };

_$_FeeCalculator _$$_FeeCalculatorFromJson(Map<String, dynamic> json) =>
    _$_FeeCalculator(
      lamportsPerSignature: json['lamportsPerSignature'] as int,
    );

Map<String, dynamic> _$$_FeeCalculatorToJson(_$_FeeCalculator instance) =>
    <String, dynamic>{
      'lamportsPerSignature': instance.lamportsPerSignature,
    };

_$_Range _$$_RangeFromJson(Map<String, dynamic> json) => _$_Range(
      firstSlot: json['firstSlot'] as int,
      lastSlot: json['lastSlot'] as int,
    );

Map<String, dynamic> _$$_RangeToJson(_$_Range instance) => <String, dynamic>{
      'firstSlot': instance.firstSlot,
      'lastSlot': instance.lastSlot,
    };

_$_BlockProduction _$$_BlockProductionFromJson(Map<String, dynamic> json) =>
    _$_BlockProduction(
      byIdentity: (json['byIdentity'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ByIdentityValue.fromJson(e)),
      ),
      range: Range.fromJson(json['range'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BlockProductionToJson(_$_BlockProduction instance) =>
    <String, dynamic>{
      'byIdentity': instance.byIdentity,
      'range': instance.range,
    };

_$_BlockCommitment _$$_BlockCommitmentFromJson(Map<String, dynamic> json) =>
    _$_BlockCommitment(
      commitment:
          (json['commitment'] as List<dynamic>?)?.map((e) => e as int).toList(),
      totalStake: json['totalStake'] as int,
    );

Map<String, dynamic> _$$_BlockCommitmentToJson(_$_BlockCommitment instance) =>
    <String, dynamic>{
      'commitment': instance.commitment,
      'totalStake': instance.totalStake,
    };

_$_EpochSchedule _$$_EpochScheduleFromJson(Map<String, dynamic> json) =>
    _$_EpochSchedule(
      slotsPerEpoch: json['slotsPerEpoch'] as int,
      leaderScheduleSlotOffset: json['leaderScheduleSlotOffset'] as int,
      warmup: json['warmup'] as bool,
      firstNormalEpoch: json['firstNormalEpoch'] as int,
      firstNormalSlot: json['firstNormalSlot'] as int,
    );

Map<String, dynamic> _$$_EpochScheduleToJson(_$_EpochSchedule instance) =>
    <String, dynamic>{
      'slotsPerEpoch': instance.slotsPerEpoch,
      'leaderScheduleSlotOffset': instance.leaderScheduleSlotOffset,
      'warmup': instance.warmup,
      'firstNormalEpoch': instance.firstNormalEpoch,
      'firstNormalSlot': instance.firstNormalSlot,
    };

_$_FeeRateGovernorValue _$$_FeeRateGovernorValueFromJson(
        Map<String, dynamic> json) =>
    _$_FeeRateGovernorValue(
      burnPercent: json['burnPercent'] as int,
      maxLamportsPerSignature: json['maxLamportsPerSignature'] as int,
      minLamportsPerSignature: json['minLamportsPerSignature'] as int,
      targetLamportsPerSignature: json['targetLamportsPerSignature'] as int,
      targetSignaturesPerSlot: json['targetSignaturesPerSlot'] as int,
    );

Map<String, dynamic> _$$_FeeRateGovernorValueToJson(
        _$_FeeRateGovernorValue instance) =>
    <String, dynamic>{
      'burnPercent': instance.burnPercent,
      'maxLamportsPerSignature': instance.maxLamportsPerSignature,
      'minLamportsPerSignature': instance.minLamportsPerSignature,
      'targetLamportsPerSignature': instance.targetLamportsPerSignature,
      'targetSignaturesPerSlot': instance.targetSignaturesPerSlot,
    };

_$_FeeRateGovernor _$$_FeeRateGovernorFromJson(Map<String, dynamic> json) =>
    _$_FeeRateGovernor(
      feeRateGovernor: FeeRateGovernorValue.fromJson(
          json['feeRateGovernor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FeeRateGovernorToJson(_$_FeeRateGovernor instance) =>
    <String, dynamic>{
      'feeRateGovernor': instance.feeRateGovernor,
    };

_$_Fees _$$_FeesFromJson(Map<String, dynamic> json) => _$_Fees(
      blockhash: json['blockhash'] as String,
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
      lastValidBlockHeight: json['lastValidBlockHeight'] as int,
    );

Map<String, dynamic> _$$_FeesToJson(_$_Fees instance) => <String, dynamic>{
      'blockhash': instance.blockhash,
      'feeCalculator': instance.feeCalculator,
      'lastValidBlockHeight': instance.lastValidBlockHeight,
    };

_$_Identity _$$_IdentityFromJson(Map<String, dynamic> json) => _$_Identity(
      identity: json['identity'] as String,
    );

Map<String, dynamic> _$$_IdentityToJson(_$_Identity instance) =>
    <String, dynamic>{
      'identity': instance.identity,
    };

_$_InflationGovernor _$$_InflationGovernorFromJson(Map<String, dynamic> json) =>
    _$_InflationGovernor(
      initial: (json['initial'] as num).toDouble(),
      terminal: (json['terminal'] as num).toDouble(),
      taper: (json['taper'] as num).toDouble(),
      foundation: (json['foundation'] as num).toDouble(),
      foundationTerm: (json['foundationTerm'] as num).toDouble(),
    );

Map<String, dynamic> _$$_InflationGovernorToJson(
        _$_InflationGovernor instance) =>
    <String, dynamic>{
      'initial': instance.initial,
      'terminal': instance.terminal,
      'taper': instance.taper,
      'foundation': instance.foundation,
      'foundationTerm': instance.foundationTerm,
    };

_$_InflationRate _$$_InflationRateFromJson(Map<String, dynamic> json) =>
    _$_InflationRate(
      total: (json['total'] as num).toDouble(),
      validator: (json['validator'] as num).toDouble(),
      foundation: (json['foundation'] as num).toDouble(),
      epoch: (json['epoch'] as num).toDouble(),
    );

Map<String, dynamic> _$$_InflationRateToJson(_$_InflationRate instance) =>
    <String, dynamic>{
      'total': instance.total,
      'validator': instance.validator,
      'foundation': instance.foundation,
      'epoch': instance.epoch,
    };

_$_InflationReward _$$_InflationRewardFromJson(Map<String, dynamic> json) =>
    _$_InflationReward(
      epoch: json['epoch'] as int,
      effectiveSlot: json['effectiveSlot'] as int,
      amount: json['amount'] as int,
      postBalance: json['postBalance'] as int,
      commission: json['commission'] as int,
    );

Map<String, dynamic> _$$_InflationRewardToJson(_$_InflationReward instance) =>
    <String, dynamic>{
      'epoch': instance.epoch,
      'effectiveSlot': instance.effectiveSlot,
      'amount': instance.amount,
      'postBalance': instance.postBalance,
      'commission': instance.commission,
    };

_$_LargeAccount _$$_LargeAccountFromJson(Map<String, dynamic> json) =>
    _$_LargeAccount(
      address: json['address'] as String,
      lamports: json['lamports'] as int,
    );

Map<String, dynamic> _$$_LargeAccountToJson(_$_LargeAccount instance) =>
    <String, dynamic>{
      'address': instance.address,
      'lamports': instance.lamports,
    };

_$_FilterParams _$$_FilterParamsFromJson(Map<String, dynamic> json) =>
    _$_FilterParams(
      offset: json['offset'] as int,
      bytes: json['bytes'] as String,
    );

Map<String, dynamic> _$$_FilterParamsToJson(_$_FilterParams instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'bytes': instance.bytes,
    };

_$_Filter _$$_FilterFromJson(Map<String, dynamic> json) => _$_Filter(
      memcmp: FilterParams.fromJson(json['memcmp'] as Map<String, dynamic>),
      dataSize: json['dataSize'] as int,
    );

Map<String, dynamic> _$$_FilterToJson(_$_Filter instance) => <String, dynamic>{
      'memcmp': instance.memcmp,
      'dataSize': instance.dataSize,
    };

_$_ProgramAccount _$$_ProgramAccountFromJson(Map<String, dynamic> json) =>
    _$_ProgramAccount(
      account: Account.fromJson(json['account'] as Map<String, dynamic>),
      pubkey: json['pubkey'] as String,
    );

Map<String, dynamic> _$$_ProgramAccountToJson(_$_ProgramAccount instance) =>
    <String, dynamic>{
      'account': instance.account,
      'pubkey': instance.pubkey,
    };

_$_RecentBlockhash _$$_RecentBlockhashFromJson(Map<String, dynamic> json) =>
    _$_RecentBlockhash(
      blockhash: json['blockhash'] as String,
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_RecentBlockhashToJson(_$_RecentBlockhash instance) =>
    <String, dynamic>{
      'blockhash': instance.blockhash,
      'feeCalculator': instance.feeCalculator,
    };

_$_PerfSample _$$_PerfSampleFromJson(Map<String, dynamic> json) =>
    _$_PerfSample(
      slot: json['slot'] as int,
      numTransactions: json['numTransactions'] as int,
      numSlots: json['numSlots'] as int,
      samplePeriodSec: json['samplePeriodSec'] as int,
    );

Map<String, dynamic> _$$_PerfSampleToJson(_$_PerfSample instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'numTransactions': instance.numTransactions,
      'numSlots': instance.numSlots,
      'samplePeriodSec': instance.samplePeriodSec,
    };

_$_TransactionSignatureInformation _$$_TransactionSignatureInformationFromJson(
        Map<String, dynamic> json) =>
    _$_TransactionSignatureInformation(
      signature: json['signature'] as String,
      slot: json['slot'] as int,
      err: json['err'] as Map<String, dynamic>?,
      memo: json['memo'] as String?,
      blockTime: json['blockTime'] as int?,
    );

Map<String, dynamic> _$$_TransactionSignatureInformationToJson(
        _$_TransactionSignatureInformation instance) =>
    <String, dynamic>{
      'signature': instance.signature,
      'slot': instance.slot,
      'err': instance.err,
      'memo': instance.memo,
      'blockTime': instance.blockTime,
    };

_$_SignatureStatus _$$_SignatureStatusFromJson(Map<String, dynamic> json) =>
    _$_SignatureStatus(
      slot: json['slot'] as int,
      confirmations: json['confirmations'] as int?,
      err: json['err'] as Map<String, dynamic>?,
      confirmationStatus:
          _$enumDecode(_$CommitmentEnumMap, json['confirmationStatus']),
    );

Map<String, dynamic> _$$_SignatureStatusToJson(_$_SignatureStatus instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'confirmations': instance.confirmations,
      'err': instance.err,
      'confirmationStatus': _$CommitmentEnumMap[instance.confirmationStatus],
    };

_$_StakeActivation _$$_StakeActivationFromJson(Map<String, dynamic> json) =>
    _$_StakeActivation(
      state: _$enumDecode(_$StakeActivationStateEnumMap, json['state']),
      active: json['active'] as int,
      inactive: json['inactive'] as int,
    );

Map<String, dynamic> _$$_StakeActivationToJson(_$_StakeActivation instance) =>
    <String, dynamic>{
      'state': _$StakeActivationStateEnumMap[instance.state],
      'active': instance.active,
      'inactive': instance.inactive,
    };

_$_Supply _$$_SupplyFromJson(Map<String, dynamic> json) => _$_Supply(
      total: json['total'] as int,
      circulating: json['circulating'] as int,
      nonCirculating: json['nonCirculating'] as int,
      nonCirculatingAccounts: (json['nonCirculatingAccounts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_SupplyToJson(_$_Supply instance) => <String, dynamic>{
      'total': instance.total,
      'circulating': instance.circulating,
      'nonCirculating': instance.nonCirculating,
      'nonCirculatingAccounts': instance.nonCirculatingAccounts,
    };

_$_SolanaVersion _$$_SolanaVersionFromJson(Map<String, dynamic> json) =>
    _$_SolanaVersion(
      solanaCore: json['solana-core'] as String,
      featureSet: json['feature-set'] as int,
    );

Map<String, dynamic> _$$_SolanaVersionToJson(_$_SolanaVersion instance) =>
    <String, dynamic>{
      'solana-core': instance.solanaCore,
      'feature-set': instance.featureSet,
    };

_$_VoteAccounts _$$_VoteAccountsFromJson(Map<String, dynamic> json) =>
    _$_VoteAccounts(
      votePubkey: json['votePubkey'] as String,
      nodePubkey: json['nodePubkey'] as String,
      activatedStake: json['activatedStake'] as int,
      epochVoteAccount: json['epochVoteAccount'] as bool,
      commission: json['commission'] as int,
      lastVote: json['lastVote'] as int,
      epochCredits:
          (json['epochCredits'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$_VoteAccountsToJson(_$_VoteAccounts instance) =>
    <String, dynamic>{
      'votePubkey': instance.votePubkey,
      'nodePubkey': instance.nodePubkey,
      'activatedStake': instance.activatedStake,
      'epochVoteAccount': instance.epochVoteAccount,
      'commission': instance.commission,
      'lastVote': instance.lastVote,
      'epochCredits': instance.epochCredits,
    };

_$_TransactionStatus _$$_TransactionStatusFromJson(Map<String, dynamic> json) =>
    _$_TransactionStatus(
      err: json['err'] as Map<String, dynamic>?,
      logs: (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TransactionStatusToJson(
        _$_TransactionStatus instance) =>
    <String, dynamic>{
      'err': instance.err,
      'logs': instance.logs,
      'accounts': instance.accounts,
    };

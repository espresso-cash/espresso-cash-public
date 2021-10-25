// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConfirmedTransactionOptions _$GetConfirmedTransactionOptionsFromJson(
        Map<String, dynamic> json) =>
    GetConfirmedTransactionOptions(
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

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

const _$EncodingEnumMap = {
  Encoding.base64: 'base64',
  Encoding.jsonParsed: 'jsonParsed',
};

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};

SimulateTransactionAccounts _$SimulateTransactionAccountsFromJson(
        Map<String, dynamic> json) =>
    SimulateTransactionAccounts(
      accountEncoding:
          _$enumDecodeNullable(_$EncodingEnumMap, json['accountEncoding']),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

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
  final val = <String, dynamic>{
    'encoding': instance.encoding,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sigVerify', instance.sigVerify);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('replaceRecentBlockhash', instance.replaceRecentBlockhash);
  writeNotNull('accounts', instance.accounts);
  return val;
}

Map<String, dynamic> _$SendTransactionOptionsToJson(
    SendTransactionOptions instance) {
  final val = <String, dynamic>{
    'encoding': instance.encoding,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('skipPreflight', instance.skipPreflight);
  writeNotNull('maxRetries', instance.maxRetries);
  return val;
}

GetVoteAccountsOptions _$GetVoteAccountsOptionsFromJson(
        Map<String, dynamic> json) =>
    GetVoteAccountsOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      votePubKey: json['votePubKey'] as String?,
      keepUnstakedDelinquents: json['keepUnstakedDelinquents'] as bool?,
      delinquentSlotDistance: json['delinquentSlotDistance'] as int?,
    );

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

GetTransactionOptions _$GetTransactionOptionsFromJson(
        Map<String, dynamic> json) =>
    GetTransactionOptions(
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

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

GetSupplyOptions _$GetSupplyOptionsFromJson(Map<String, dynamic> json) =>
    GetSupplyOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      excludeNonCirculatingAccountsList:
          json['excludeNonCirculatingAccountsList'] as bool?,
    );

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

GetStakeActivationOptions _$GetStakeActivationOptionsFromJson(
        Map<String, dynamic> json) =>
    GetStakeActivationOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      epoch: json['epoch'] as int?,
    );

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

GetSignatureStatusesOptions _$GetSignatureStatusesOptionsFromJson(
        Map<String, dynamic> json) =>
    GetSignatureStatusesOptions(
      searchTransactionHistory: json['searchTransactionHistory'] as bool?,
    );

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

GetSignaturesForAddressOptions _$GetSignaturesForAddressOptionsFromJson(
        Map<String, dynamic> json) =>
    GetSignaturesForAddressOptions(
      limit: json['limit'] as int?,
      before: json['before'] as String?,
      until: json['until'] as String?,
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

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

GetProgramAccountsOptions _$GetProgramAccountsOptionsFromJson(
        Map<String, dynamic> json) =>
    GetProgramAccountsOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      dataSlice: json['dataSlice'] == null
          ? null
          : DataSlice.fromJson(json['dataSlice'] as Map<String, dynamic>),
      filter: (json['filter'] as List<dynamic>?)
          ?.map((e) => Filter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

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

GetLeaderScheduleOptions _$GetLeaderScheduleOptionsFromJson(
        Map<String, dynamic> json) =>
    GetLeaderScheduleOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      identity: json['identity'] as String?,
    );

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

GetLargestAccountsOptions _$GetLargestAccountsOptionsFromJson(
        Map<String, dynamic> json) =>
    GetLargestAccountsOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      filter: _$enumDecodeNullable(_$CirculationStatusEnumMap, json['filter']),
    );

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

GetBlockProductionOptions _$GetBlockProductionOptionsFromJson(
        Map<String, dynamic> json) =>
    GetBlockProductionOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      range: json['range'] == null
          ? null
          : Range.fromJson(json['range'] as Map<String, dynamic>),
      identity: json['identity'] as String?,
    );

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

GetBlockOptions _$GetBlockOptionsFromJson(Map<String, dynamic> json) =>
    GetBlockOptions(
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      transactionDetails: _$enumDecodeNullable(
          _$TransactionDetailLevelEnumMap, json['transactionDetails']),
      rewards: json['rewards'] as bool?,
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

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

GetAccountInfoOptions _$GetAccountInfoOptionsFromJson(
        Map<String, dynamic> json) =>
    GetAccountInfoOptions(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
      encoding: _$enumDecodeNullable(_$EncodingEnumMap, json['encoding']),
      dataSlice: json['dataSlice'] == null
          ? null
          : DataSlice.fromJson(json['dataSlice'] as Map<String, dynamic>),
    );

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

MintOrProgramId _$MintOrProgramIdFromJson(Map<String, dynamic> json) =>
    MintOrProgramId(
      mint: json['mint'] as String?,
      programId: json['programId'] as String?,
    );

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

DataSlice _$DataSliceFromJson(Map<String, dynamic> json) => DataSlice(
      offset: json['offset'] as int?,
      length: json['length'] as int?,
    );

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

CommitmentObject _$CommitmentObjectFromJson(Map<String, dynamic> json) =>
    CommitmentObject(
      commitment: _$enumDecodeNullable(_$CommitmentEnumMap, json['commitment']),
    );

Map<String, dynamic> _$CommitmentObjectToJson(CommitmentObject instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      lamports: json['lamports'] as int,
      owner: json['owner'] as String,
      data: const AccountDataConverter().fromJson(json['data']),
      executable: json['executable'] as bool,
      rentEpoch: json['rentEpoch'] as int,
    );

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

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
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

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
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

Reward _$RewardFromJson(Map<String, dynamic> json) => Reward(
      pubkey: json['pubkey'] as String,
      lamports: json['lamports'] as int,
      postBalance: json['postBalance'] as int,
      rewardType: _$enumDecode(_$RewardTypeEnumMap, json['rewardType']),
      commission: json['commission'] as int,
    );

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

TransactionMessageHeader _$TransactionMessageHeaderFromJson(
        Map<String, dynamic> json) =>
    TransactionMessageHeader(
      numRequiredSignatures: json['numRequiredSignatures'] as int,
      numReadonlySignedAccounts: json['numReadonlySignedAccounts'] as int,
      numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'] as int,
    );

Map<String, dynamic> _$TransactionMessageHeaderToJson(
        TransactionMessageHeader instance) =>
    <String, dynamic>{
      'numRequiredSignatures': instance.numRequiredSignatures,
      'numReadonlySignedAccounts': instance.numReadonlySignedAccounts,
      'numReadonlyUnsignedAccounts': instance.numReadonlyUnsignedAccounts,
    };

TransactionMessage _$TransactionMessageFromJson(Map<String, dynamic> json) =>
    TransactionMessage(
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

Map<String, dynamic> _$TransactionMessageToJson(TransactionMessage instance) =>
    <String, dynamic>{
      'accountKeys': instance.accountKeys,
      'header': instance.header,
      'recentBlockhash': instance.recentBlockhash,
      'instructions': instance.instructions,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      signatures: (json['signatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      message:
          TransactionMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'signatures': instance.signatures,
      'message': instance.message,
    };

TransactionDetails _$TransactionDetailsFromJson(Map<String, dynamic> json) =>
    TransactionDetails(
      slot: json['slot'] as int,
      transaction:
          Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
      blockTime: json['blockTime'] as int?,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

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

InnerInstruction _$InnerInstructionFromJson(Map<String, dynamic> json) =>
    InnerInstruction(
      index: json['index'] as int,
      instruction: (json['instruction'] as List<dynamic>)
          .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InnerInstructionToJson(InnerInstruction instance) =>
    <String, dynamic>{
      'index': instance.index,
      'instruction': instance.instruction,
    };

Instruction _$InstructionFromJson(Map<String, dynamic> json) => Instruction(
      programIdIndex: json['programIdIndex'] as int,
      accounts:
          (json['accounts'] as List<dynamic>).map((e) => e as int).toList(),
      data: json['data'] as String,
    );

Map<String, dynamic> _$InstructionToJson(Instruction instance) =>
    <String, dynamic>{
      'programIdIndex': instance.programIdIndex,
      'accounts': instance.accounts,
      'data': instance.data,
    };

TokenAmount _$TokenAmountFromJson(Map<String, dynamic> json) => TokenAmount(
      amount: json['amount'] as String,
      decimals: json['decimals'] as int,
      uiAmountString: json['uiAmountString'] as String?,
    );

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

TokenBalance _$TokenBalanceFromJson(Map<String, dynamic> json) => TokenBalance(
      accountIndex: json['accountIndex'] as int,
      mint: json['mint'] as String,
      uiTokenAmount:
          TokenAmount.fromJson(json['uiTokenAmount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenBalanceToJson(TokenBalance instance) =>
    <String, dynamic>{
      'accountIndex': instance.accountIndex,
      'mint': instance.mint,
      'uiTokenAmount': instance.uiTokenAmount,
    };

ClusterNode _$ClusterNodeFromJson(Map<String, dynamic> json) => ClusterNode(
      pubkey: json['pubkey'] as String,
      gossip: json['gossip'] as String,
      tpu: json['tpu'] as String,
      rpc: json['rpc'] as String?,
      version: json['version'] as String?,
      featureSet: json['featureSet'] as int?,
      shredVersion: json['shredVersion'] as int?,
    );

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

EpochInfo _$EpochInfoFromJson(Map<String, dynamic> json) => EpochInfo(
      absoluteSlot: json['absoluteSlot'] as int,
      blockHeight: json['blockHeight'] as int,
      epoch: json['epoch'] as int,
      slotIndex: json['slotIndex'] as int,
      slotsInEpoch: json['slotsInEpoch'] as int,
    );

Map<String, dynamic> _$EpochInfoToJson(EpochInfo instance) => <String, dynamic>{
      'absoluteSlot': instance.absoluteSlot,
      'blockHeight': instance.blockHeight,
      'epoch': instance.epoch,
      'slotIndex': instance.slotIndex,
      'slotsInEpoch': instance.slotsInEpoch,
    };

FeeCalculator _$FeeCalculatorFromJson(Map<String, dynamic> json) =>
    FeeCalculator(
      lamportsPerSignature: json['lamportsPerSignature'] as int,
    );

Map<String, dynamic> _$FeeCalculatorToJson(FeeCalculator instance) =>
    <String, dynamic>{
      'lamportsPerSignature': instance.lamportsPerSignature,
    };

Range _$RangeFromJson(Map<String, dynamic> json) => Range(
      firstSlot: json['firstSlot'] as int,
      lastSlot: json['lastSlot'] as int,
    );

Map<String, dynamic> _$RangeToJson(Range instance) => <String, dynamic>{
      'firstSlot': instance.firstSlot,
      'lastSlot': instance.lastSlot,
    };

BlockProduction _$BlockProductionFromJson(Map<String, dynamic> json) =>
    BlockProduction(
      byIdentity: (json['byIdentity'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ByIdentityValue.fromJson(e)),
      ),
      range: Range.fromJson(json['range'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlockProductionToJson(BlockProduction instance) =>
    <String, dynamic>{
      'byIdentity': instance.byIdentity,
      'range': instance.range,
    };

BlockCommitment _$BlockCommitmentFromJson(Map<String, dynamic> json) =>
    BlockCommitment(
      commitment:
          (json['commitment'] as List<dynamic>?)?.map((e) => e as int).toList(),
      totalStake: json['totalStake'] as int,
    );

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

EpochSchedule _$EpochScheduleFromJson(Map<String, dynamic> json) =>
    EpochSchedule(
      slotsPerEpoch: json['slotsPerEpoch'] as int,
      leaderScheduleSlotOffset: json['leaderScheduleSlotOffset'] as int,
      warmup: json['warmup'] as bool,
      firstNormalEpoch: json['firstNormalEpoch'] as int,
      firstNormalSlot: json['firstNormalSlot'] as int,
    );

Map<String, dynamic> _$EpochScheduleToJson(EpochSchedule instance) =>
    <String, dynamic>{
      'slotsPerEpoch': instance.slotsPerEpoch,
      'leaderScheduleSlotOffset': instance.leaderScheduleSlotOffset,
      'warmup': instance.warmup,
      'firstNormalEpoch': instance.firstNormalEpoch,
      'firstNormalSlot': instance.firstNormalSlot,
    };

FeeRateGovernorValue _$FeeRateGovernorValueFromJson(
        Map<String, dynamic> json) =>
    FeeRateGovernorValue(
      burnPercent: json['burnPercent'] as int,
      maxLamportsPerSignature: json['maxLamportsPerSignature'] as int,
      minLamportsPerSignature: json['minLamportsPerSignature'] as int,
      targetLamportsPerSignature: json['targetLamportsPerSignature'] as int,
      targetSignaturesPerSlot: json['targetSignaturesPerSlot'] as int,
    );

Map<String, dynamic> _$FeeRateGovernorValueToJson(
        FeeRateGovernorValue instance) =>
    <String, dynamic>{
      'burnPercent': instance.burnPercent,
      'maxLamportsPerSignature': instance.maxLamportsPerSignature,
      'minLamportsPerSignature': instance.minLamportsPerSignature,
      'targetLamportsPerSignature': instance.targetLamportsPerSignature,
      'targetSignaturesPerSlot': instance.targetSignaturesPerSlot,
    };

FeeRateGovernor _$FeeRateGovernorFromJson(Map<String, dynamic> json) =>
    FeeRateGovernor(
      feeRateGovernor: FeeRateGovernorValue.fromJson(
          json['feeRateGovernor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeeRateGovernorToJson(FeeRateGovernor instance) =>
    <String, dynamic>{
      'feeRateGovernor': instance.feeRateGovernor,
    };

Fees _$FeesFromJson(Map<String, dynamic> json) => Fees(
      blockhash: json['blockhash'] as String,
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
      lastValidBlockHeight: json['lastValidBlockHeight'] as int,
    );

Map<String, dynamic> _$FeesToJson(Fees instance) => <String, dynamic>{
      'blockhash': instance.blockhash,
      'feeCalculator': instance.feeCalculator,
      'lastValidBlockHeight': instance.lastValidBlockHeight,
    };

Identity _$IdentityFromJson(Map<String, dynamic> json) => Identity(
      identity: json['identity'] as String,
    );

Map<String, dynamic> _$IdentityToJson(Identity instance) => <String, dynamic>{
      'identity': instance.identity,
    };

InflationGovernor _$InflationGovernorFromJson(Map<String, dynamic> json) =>
    InflationGovernor(
      initial: (json['initial'] as num).toDouble(),
      terminal: (json['terminal'] as num).toDouble(),
      taper: (json['taper'] as num).toDouble(),
      foundation: (json['foundation'] as num).toDouble(),
      foundationTerm: (json['foundationTerm'] as num).toDouble(),
    );

Map<String, dynamic> _$InflationGovernorToJson(InflationGovernor instance) =>
    <String, dynamic>{
      'initial': instance.initial,
      'terminal': instance.terminal,
      'taper': instance.taper,
      'foundation': instance.foundation,
      'foundationTerm': instance.foundationTerm,
    };

InflationRate _$InflationRateFromJson(Map<String, dynamic> json) =>
    InflationRate(
      total: (json['total'] as num).toDouble(),
      validator: (json['validator'] as num).toDouble(),
      foundation: (json['foundation'] as num).toDouble(),
      epoch: (json['epoch'] as num).toDouble(),
    );

Map<String, dynamic> _$InflationRateToJson(InflationRate instance) =>
    <String, dynamic>{
      'total': instance.total,
      'validator': instance.validator,
      'foundation': instance.foundation,
      'epoch': instance.epoch,
    };

InflationReward _$InflationRewardFromJson(Map<String, dynamic> json) =>
    InflationReward(
      epoch: json['epoch'] as int,
      effectiveSlot: json['effectiveSlot'] as int,
      amount: json['amount'] as int,
      postBalance: json['postBalance'] as int,
      commission: json['commission'] as int,
    );

Map<String, dynamic> _$InflationRewardToJson(InflationReward instance) =>
    <String, dynamic>{
      'epoch': instance.epoch,
      'effectiveSlot': instance.effectiveSlot,
      'amount': instance.amount,
      'postBalance': instance.postBalance,
      'commission': instance.commission,
    };

LargeAccount _$LargeAccountFromJson(Map<String, dynamic> json) => LargeAccount(
      address: json['address'] as String,
      lamports: json['lamports'] as int,
    );

Map<String, dynamic> _$LargeAccountToJson(LargeAccount instance) =>
    <String, dynamic>{
      'address': instance.address,
      'lamports': instance.lamports,
    };

FilterParams _$FilterParamsFromJson(Map<String, dynamic> json) => FilterParams(
      offset: json['offset'] as int,
      bytes: json['bytes'] as String,
    );

Map<String, dynamic> _$FilterParamsToJson(FilterParams instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'bytes': instance.bytes,
    };

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      memcmp: FilterParams.fromJson(json['memcmp'] as Map<String, dynamic>),
      dataSize: json['dataSize'] as int,
    );

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'memcmp': instance.memcmp,
      'dataSize': instance.dataSize,
    };

ProgramAccount _$ProgramAccountFromJson(Map<String, dynamic> json) =>
    ProgramAccount(
      account: Account.fromJson(json['account'] as Map<String, dynamic>),
      pubkey: json['pubkey'] as String,
    );

Map<String, dynamic> _$ProgramAccountToJson(ProgramAccount instance) =>
    <String, dynamic>{
      'account': instance.account,
      'pubkey': instance.pubkey,
    };

RecentBlockhash _$RecentBlockhashFromJson(Map<String, dynamic> json) =>
    RecentBlockhash(
      blockhash: json['blockhash'] as String,
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecentBlockhashToJson(RecentBlockhash instance) =>
    <String, dynamic>{
      'blockhash': instance.blockhash,
      'feeCalculator': instance.feeCalculator,
    };

PerfSample _$PerfSampleFromJson(Map<String, dynamic> json) => PerfSample(
      slot: json['slot'] as int,
      numTransactions: json['numTransactions'] as int,
      numSlots: json['numSlots'] as int,
      samplePeriodSec: json['samplePeriodSec'] as int,
    );

Map<String, dynamic> _$PerfSampleToJson(PerfSample instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'numTransactions': instance.numTransactions,
      'numSlots': instance.numSlots,
      'samplePeriodSec': instance.samplePeriodSec,
    };

TransactionSignatureInformation _$TransactionSignatureInformationFromJson(
        Map<String, dynamic> json) =>
    TransactionSignatureInformation(
      signature: json['signature'] as String,
      slot: json['slot'] as int,
      err: json['err'] as Map<String, dynamic>?,
      memo: json['memo'] as String?,
      blockTime: json['blockTime'] as int?,
    );

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

SignatureStatus _$SignatureStatusFromJson(Map<String, dynamic> json) =>
    SignatureStatus(
      slot: json['slot'] as int,
      confirmations: json['confirmations'] as int?,
      err: json['err'] as Map<String, dynamic>?,
      confirmationStatus:
          _$enumDecode(_$CommitmentEnumMap, json['confirmationStatus']),
    );

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

StakeActivation _$StakeActivationFromJson(Map<String, dynamic> json) =>
    StakeActivation(
      state: _$enumDecode(_$StakeActivationStateEnumMap, json['state']),
      active: json['active'] as int,
      inactive: json['inactive'] as int,
    );

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

Supply _$SupplyFromJson(Map<String, dynamic> json) => Supply(
      total: json['total'] as int,
      circulating: json['circulating'] as int,
      nonCirculating: json['nonCirculating'] as int,
      nonCirculatingAccounts: (json['nonCirculatingAccounts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SupplyToJson(Supply instance) => <String, dynamic>{
      'total': instance.total,
      'circulating': instance.circulating,
      'nonCirculating': instance.nonCirculating,
      'nonCirculatingAccounts': instance.nonCirculatingAccounts,
    };

SolanaVersion _$SolanaVersionFromJson(Map<String, dynamic> json) =>
    SolanaVersion(
      solanaCore: json['solana-core'] as String,
      featureSet: json['feature-set'] as int,
    );

Map<String, dynamic> _$SolanaVersionToJson(SolanaVersion instance) =>
    <String, dynamic>{
      'solana-core': instance.solanaCore,
      'feature-set': instance.featureSet,
    };

VoteAccounts _$VoteAccountsFromJson(Map<String, dynamic> json) => VoteAccounts(
      votePubkey: json['votePubkey'] as String,
      nodePubkey: json['nodePubkey'] as String,
      activatedStake: json['activatedStake'] as int,
      epochVoteAccount: json['epochVoteAccount'] as bool,
      commission: json['commission'] as int,
      lastVote: json['lastVote'] as int,
      epochCredits:
          (json['epochCredits'] as List<dynamic>).map((e) => e as int).toList(),
    );

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

TransactionStatus _$TransactionStatusFromJson(Map<String, dynamic> json) =>
    TransactionStatus(
      err: json['err'] as Map<String, dynamic>?,
      logs: (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of rpc_client;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    owner: json['owner'] as String,
    lamports: json['lamports'] as int,
    executable: json['executable'] as bool,
    rentEpoch: json['rentEpoch'] as int,
    data: json['data'],
  );
}

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) {
  return AccountInfoResponse(
    ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
        (value) => Account.fromJson(value as Map<String, dynamic>)),
  );
}

AccountKey _$AccountKeyFromJson(Map<String, dynamic> json) {
  return AccountKey(
    pubkey: json['pubkey'] as String,
  );
}

BalanceResponse _$BalanceResponseFromJson(Map<String, dynamic> json) {
  return BalanceResponse(
    ValueResponse.fromJson(
        json['result'] as Map<String, dynamic>, (value) => value as int),
  );
}

Blockhash _$BlockhashFromJson(Map<String, dynamic> json) {
  return Blockhash(
    feeCalculator:
        FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
    blockhash: json['blockhash'] as String,
  );
}

BlockhashResponse _$BlockhashResponseFromJson(Map<String, dynamic> json) {
  return BlockhashResponse(
    ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
        (value) => Blockhash.fromJson(value as Map<String, dynamic>)),
  );
}

ConfirmedSignature _$ConfirmedSignatureFromJson(Map<String, dynamic> json) {
  return ConfirmedSignature(
    signature: json['signature'] as String,
    slot: json['slot'] as int,
    err: json['err'],
    memo: json['memo'] as String?,
    blockTime: json['blockTime'] as int?,
  );
}

ConfirmedSignaturesResponse _$ConfirmedSignaturesResponseFromJson(
    Map<String, dynamic> json) {
  return ConfirmedSignaturesResponse(
    (json['result'] as List<dynamic>)
        .map((e) => ConfirmedSignature.fromJson(e as Map<String, dynamic>)),
  );
}

ConfirmedTransactionResponse _$ConfirmedTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return ConfirmedTransactionResponse(
    json['result'] == null
        ? null
        : TransactionResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}

FeeCalculator _$FeeCalculatorFromJson(Map<String, dynamic> json) {
  return FeeCalculator(
    lamportsPerSignature: json['lamportsPerSignature'] as int,
  );
}

GetTransactionResponse _$GetTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return GetTransactionResponse(
    TransactionResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}

ValueResponse<T> _$ValueResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return ValueResponse<T>(
    value: fromJsonT(json['value']),
  );
}

TxMessage _$TxMessageFromJson(Map<String, dynamic> json) {
  return TxMessage(
    header: json['header'] == null
        ? null
        : TxMessageHeader.fromJson(json['header'] as Map<String, dynamic>),
    accountKeys: (json['accountKeys'] as List<dynamic>)
        .map((e) => AccountKey.fromJson(e as Map<String, dynamic>))
        .toList(),
    recentBlockhash: json['recentBlockhash'] as String,
    instructions: (json['instructions'] as List<dynamic>)
        .map((e) => ParsedInstruction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

TxMessageHeader _$TxMessageHeaderFromJson(Map<String, dynamic> json) {
  return TxMessageHeader(
    numRequiredSignatures: json['numRequiredSignatures'] as int,
    numReadonlySignedAccounts: json['numReadonlySignedAccounts'] as int,
    numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'] as int,
  );
}

Meta _$MetaFromJson(Map<String, dynamic> json) {
  return Meta(
    err: json['err'],
    rewards: (json['rewards'] as List<dynamic>?)
        ?.map((e) => Reward.fromJson(e as Map<String, dynamic>))
        .toList(),
    fee: json['fee'] as int,
    preBalances: json['preBalances'] as List<dynamic>,
    postBalances: json['postBalances'] as List<dynamic>,
    innerInstructions: json['innerInstructions'] as List<dynamic>,
    preTokenBalances: json['preTokenBalances'] as List<dynamic>,
    postTokenBalances: json['postTokenBalances'] as List<dynamic>,
    logMessages:
        (json['logMessages'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Reward _$RewardFromJson(Map<String, dynamic> json) {
  return Reward(
    pubkey: json['pubkey'] as String,
    lamports: json['lamports'] as int,
    postBalance: json['postBalance'] as int,
    rewardType: json['rewardType'] as String,
  );
}

MinimumBalanceForRentExemptionResponse
    _$MinimumBalanceForRentExemptionResponseFromJson(
        Map<String, dynamic> json) {
  return MinimumBalanceForRentExemptionResponse(
    json['result'] as int,
  );
}

_$ParsedInstructionSystem _$_$ParsedInstructionSystemFromJson(
    Map<String, dynamic> json) {
  return _$ParsedInstructionSystem(
    programId: json['programId'] as String,
    parsed: ParsedSystemInstruction.fromJson(
        json['parsed'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$ParsedInstructionSystemToJson(
        _$ParsedInstructionSystem instance) =>
    <String, dynamic>{
      'programId': instance.programId,
      'parsed': instance.parsed,
    };

_$ParsedInstructionSplToken _$_$ParsedInstructionSplTokenFromJson(
    Map<String, dynamic> json) {
  return _$ParsedInstructionSplToken(
    parsed: ParsedSplTokenInstruction.fromJson(
        json['parsed'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$ParsedInstructionSplTokenToJson(
        _$ParsedInstructionSplToken instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
    };

_$ParsedInstructionMemo _$_$ParsedInstructionMemoFromJson(
    Map<String, dynamic> json) {
  return _$ParsedInstructionMemo(
    memo: json['parsed'] as String?,
  );
}

Map<String, dynamic> _$_$ParsedInstructionMemoToJson(
        _$ParsedInstructionMemo instance) =>
    <String, dynamic>{
      'parsed': instance.memo,
    };

_$ParsedInstructionUnsupported _$_$ParsedInstructionUnsupportedFromJson(
    Map<String, dynamic> json) {
  return _$ParsedInstructionUnsupported(
    program: json['program'] as String,
  );
}

Map<String, dynamic> _$_$ParsedInstructionUnsupportedToJson(
        _$ParsedInstructionUnsupported instance) =>
    <String, dynamic>{
      'program': instance.program,
    };

_$ParsedSplTokenTransferInstruction
    _$_$ParsedSplTokenTransferInstructionFromJson(Map<String, dynamic> json) {
  return _$ParsedSplTokenTransferInstruction(
    info: ParsedSplTokenTransferInformation.fromJson(
        json['info'] as Map<String, dynamic>),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$_$ParsedSplTokenTransferInstructionToJson(
        _$ParsedSplTokenTransferInstruction instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
    };

_$ParsedSplTokenUnsupportedInstruction
    _$_$ParsedSplTokenUnsupportedInstructionFromJson(
        Map<String, dynamic> json) {
  return _$ParsedSplTokenUnsupportedInstruction(
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$_$ParsedSplTokenUnsupportedInstructionToJson(
        _$ParsedSplTokenUnsupportedInstruction instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

_$_ParsedSplTokenTransferInformation
    _$_$_ParsedSplTokenTransferInformationFromJson(Map<String, dynamic> json) {
  return _$_ParsedSplTokenTransferInformation(
    amount: json['amount'] as String,
    authority: json['authority'] as String,
    source: json['source'] as String,
    destination: json['destination'] as String,
  );
}

Map<String, dynamic> _$_$_ParsedSplTokenTransferInformationToJson(
        _$_ParsedSplTokenTransferInformation instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'authority': instance.authority,
      'source': instance.source,
      'destination': instance.destination,
    };

_$ParsedSystemTransferInstruction _$_$ParsedSystemTransferInstructionFromJson(
    Map<String, dynamic> json) {
  return _$ParsedSystemTransferInstruction(
    info: ParsedSystemTransferInformation.fromJson(
        json['info'] as Map<String, dynamic>),
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$_$ParsedSystemTransferInstructionToJson(
        _$ParsedSystemTransferInstruction instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
    };

_$ParsedSystemUnsupportedInstruction
    _$_$ParsedSystemUnsupportedInstructionFromJson(Map<String, dynamic> json) {
  return _$ParsedSystemUnsupportedInstruction(
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$_$ParsedSystemUnsupportedInstructionToJson(
        _$ParsedSystemUnsupportedInstruction instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

_$_ParsedSystemTransferInformation _$_$_ParsedSystemTransferInformationFromJson(
    Map<String, dynamic> json) {
  return _$_ParsedSystemTransferInformation(
    lamports: json['lamports'] as int,
    source: json['source'] as String,
    destination: json['destination'] as String,
  );
}

Map<String, dynamic> _$_$_ParsedSystemTransferInformationToJson(
        _$_ParsedSystemTransferInformation instance) =>
    <String, dynamic>{
      'lamports': instance.lamports,
      'source': instance.source,
      'destination': instance.destination,
    };

SignatureStatus _$SignatureStatusFromJson(Map<String, dynamic> json) {
  return SignatureStatus(
    slot: json['slot'] as int,
    confirmations: json['confirmations'] as int?,
    err: json['err'],
    confirmationStatus:
        _$enumDecodeNullable(_$CommitmentEnumMap, json['confirmationStatus']),
  );
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

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};

SignatureStatusesResponse _$SignatureStatusesResponseFromJson(
    Map<String, dynamic> json) {
  return SignatureStatusesResponse(
    ValueResponse.fromJson(
        json['result'] as Map<String, dynamic>,
        (value) => (value as List<dynamic>).map((e) => e == null
            ? null
            : SignatureStatus.fromJson(e as Map<String, dynamic>))),
  );
}

SimulateTxResult _$SimulateTxResultFromJson(Map<String, dynamic> json) {
  return SimulateTxResult(
    err: json['err'],
    logs: json['logs'] as List<dynamic>?,
  );
}

SimulateTxResultResponse _$SimulateTxResultResponseFromJson(
    Map<String, dynamic> json) {
  return SimulateTxResultResponse(
    ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
        (value) => SimulateTxResult.fromJson(value as Map<String, dynamic>)),
  );
}

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    message: json['message'] == null
        ? null
        : TxMessage.fromJson(json['message'] as Map<String, dynamic>),
    signatures:
        (json['signatures'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

TransactionResult _$TransactionResultFromJson(Map<String, dynamic> json) {
  return TransactionResult(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    slot: json['slot'] as int,
    blockTime: json['blockTime'] as int,
    transaction:
        Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
  );
}

TxSignatureResponse _$TxSignatureResponseFromJson(Map<String, dynamic> json) {
  return TxSignatureResponse(
    TxSignature.fromJson(json['result'] as String),
  );
}

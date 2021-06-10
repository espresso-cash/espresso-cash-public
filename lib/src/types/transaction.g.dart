// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmedTransactionResponse _$ConfirmedTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return ConfirmedTransactionResponse(
    json['result'] == null
        ? null
        : GetTransactionResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}

GetTransactionResponse _$GetTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return GetTransactionResponse(
    GetTransactionResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}

GetTransactionResult _$GetTransactionResultFromJson(Map<String, dynamic> json) {
  return GetTransactionResult(
    meta: json['meta'] == null
        ? null
        : TxMeta.fromJson(json['meta'] as Map<String, dynamic>),
    slot: json['slot'] as int,
    blockTime: json['blockTime'] as int,
    transaction:
        Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
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

TxMessageHeader _$TxMessageHeaderFromJson(Map<String, dynamic> json) {
  return TxMessageHeader(
    numRequiredSignatures: json['numRequiredSignatures'] as int,
    numReadonlySignedAccounts: json['numReadonlySignedAccounts'] as int,
    numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'] as int,
  );
}

_TxInstruction _$_TxInstructionFromJson(Map<String, dynamic> json) {
  return _TxInstruction(
    programId: json['programId'] as String,
    program: _$enumDecode(_$ProgramEnumMap, json['program']),
    parsed: json['parsed'],
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

const _$ProgramEnumMap = {
  Program.system: 'system',
  Program.memo: 'spl-memo',
};

_ParsedTransferInstruction _$_ParsedTransferInstructionFromJson(
    Map<String, dynamic> json) {
  return _ParsedTransferInstruction(
    info: json['info'] as Map<String, dynamic>,
    type: json['type'] as String,
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
        .map((e) => TxInstruction.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

AccountKey _$AccountKeyFromJson(Map<String, dynamic> json) {
  return AccountKey(
    pubkey: json['pubkey'] as String,
  );
}

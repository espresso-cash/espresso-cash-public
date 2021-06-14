// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TxSystemInstruction _$_$TxSystemInstructionFromJson(
    Map<String, dynamic> json) {
  return _$TxSystemInstruction(
    programId: json['programId'] as String,
    parsed: SystemInstruction.fromJson(json['parsed'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$TxSystemInstructionToJson(
        _$TxSystemInstruction instance) =>
    <String, dynamic>{
      'programId': instance.programId,
      'parsed': instance.parsed,
    };

_$TxMemoInstruction _$_$TxMemoInstructionFromJson(Map<String, dynamic> json) {
  return _$TxMemoInstruction(
    memo: json['parsed'] as String?,
  );
}

Map<String, dynamic> _$_$TxMemoInstructionToJson(
        _$TxMemoInstruction instance) =>
    <String, dynamic>{
      'parsed': instance.memo,
    };

_$_TxUnsupportedInstruction _$_$_TxUnsupportedInstructionFromJson(
    Map<String, dynamic> json) {
  return _$_TxUnsupportedInstruction(
    program: json['program'] as String,
  );
}

Map<String, dynamic> _$_$_TxUnsupportedInstructionToJson(
        _$_TxUnsupportedInstruction instance) =>
    <String, dynamic>{
      'program': instance.program,
    };

_$TxSystemInstructionTransfer _$_$TxSystemInstructionTransferFromJson(
    Map<String, dynamic> json) {
  return _$TxSystemInstructionTransfer(
    info: TransferInfo.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$TxSystemInstructionTransferToJson(
        _$TxSystemInstructionTransfer instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

_$TxSystemInstructionUnsupported _$_$TxSystemInstructionUnsupportedFromJson(
    Map<String, dynamic> json) {
  return _$TxSystemInstructionUnsupported(
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$_$TxSystemInstructionUnsupportedToJson(
        _$TxSystemInstructionUnsupported instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

_$_TransferInfo _$_$_TransferInfoFromJson(Map<String, dynamic> json) {
  return _$_TransferInfo(
    lamports: json['lamports'] as int,
    source: json['source'] as String,
    destination: json['destination'] as String,
  );
}

Map<String, dynamic> _$_$_TransferInfoToJson(_$_TransferInfo instance) =>
    <String, dynamic>{
      'lamports': instance.lamports,
      'source': instance.source,
      'destination': instance.destination,
    };

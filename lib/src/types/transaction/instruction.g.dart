// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Instruction _$_InstructionFromJson(Map<String, dynamic> json) {
  return _Instruction(
    programId: json['programId'] as String,
    program: _$enumDecode(_$ProgramTypeEnumMap, json['program']),
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

const _$ProgramTypeEnumMap = {
  ProgramType.system: 'system',
  ProgramType.memo: 'spl-memo',
};

_ParsedTransferInstruction _$_ParsedTransferInstructionFromJson(
    Map<String, dynamic> json) {
  return _ParsedTransferInstruction(
    info: json['info'] as Map<String, dynamic>,
    type: json['type'] as String,
  );
}

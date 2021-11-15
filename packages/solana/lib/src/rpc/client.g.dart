// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GetAccountInfoConfigToJson(
    GetAccountInfoConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('encoding', instance.encoding);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  return val;
}

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
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
  writeNotNull('range', instance.range);
  writeNotNull('identity', instance.identity);
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

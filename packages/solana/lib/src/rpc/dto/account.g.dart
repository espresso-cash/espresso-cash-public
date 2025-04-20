// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountResult _$AccountResultFromJson(Map<String, dynamic> json) => AccountResult(
  context: Context.fromJson(json['context'] as Map<String, dynamic>),
  value: json['value'] == null ? null : Account.fromJson(json['value'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AccountResultToJson(AccountResult instance) => <String, dynamic>{
  'context': instance.context.toJson(),
  'value': instance.value?.toJson(),
};

MultipleAccountsResult _$MultipleAccountsResultFromJson(Map<String, dynamic> json) =>
    MultipleAccountsResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value:
          (json['value'] as List<dynamic>)
              .map((e) => e == null ? null : Account.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MultipleAccountsResultToJson(MultipleAccountsResult instance) =>
    <String, dynamic>{
      'context': instance.context.toJson(),
      'value': instance.value.map((e) => e?.toJson()).toList(),
    };

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) => _$AccountImpl(
  lamports: (json['lamports'] as num).toInt(),
  owner: json['owner'] as String,
  data: json['data'] == null ? null : AccountData.fromJson(json['data']),
  executable: json['executable'] as bool,
  rentEpoch: bigIntFromJson(json['rentEpoch'] as Object),
);

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) => <String, dynamic>{
  'lamports': instance.lamports,
  'owner': instance.owner,
  'data': instance.data?.toJson(),
  'executable': instance.executable,
  'rentEpoch': instance.rentEpoch.toString(),
};

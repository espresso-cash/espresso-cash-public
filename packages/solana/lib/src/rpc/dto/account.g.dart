// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

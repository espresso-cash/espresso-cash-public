// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cluster_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

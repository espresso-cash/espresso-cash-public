// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cluster_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClusterNode _$ClusterNodeFromJson(Map<String, dynamic> json) => ClusterNode(
      pubkey: json['pubkey'] as String,
      gossip: json['gossip'] as String?,
      tpu: json['tpu'] as String?,
      rpc: json['rpc'] as String?,
      version: json['version'] as String?,
      featureSet: json['featureSet'] as int?,
      shredVersion: json['shredVersion'] as int?,
    );

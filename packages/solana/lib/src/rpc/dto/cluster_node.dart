import 'package:json_annotation/json_annotation.dart';

part 'cluster_node.g.dart';

/// A node of a cluster
@JsonSerializable()
class ClusterNode {
  const ClusterNode({
    required this.pubkey,
    required this.gossip,
    required this.tpu,
    required this.rpc,
    required this.version,
    required this.featureSet,
    required this.shredVersion,
  });

  factory ClusterNode.fromJson(Map<String, dynamic> json) =>
      _$ClusterNodeFromJson(json);

  /// Node public key, as base-58 encoded string
  final String pubkey;

  /// Gossip network address for the node
  final String? gossip;

  /// TPU network address for the node
  final String? tpu;

  /// JSON RPC network address for the node, or null if the JSON
  /// RPC service is not enabled
  final String? rpc;

  /// The software version of the node, or null if the version
  /// information is not available
  final String? version;

  /// The unique identifier of the node's feature set
  final int? featureSet;

  /// The shred version the node has been configured to use
  final int? shredVersion;
}

/// The [commitment] of a transaction
///
/// [commitment]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
enum Commitment {
  /// The node will query its most recent block. Note that the block may not be
  /// complete.
  processed,

  /// The node will query the most recent block that has been voted on by
  /// supermajority of the cluster.
  ///
  /// - It incorporates votes from gossip and replay.
  /// - It does not count votes on descendants of a block, only direct votes on that block.
  /// - This confirmation level also upholds "optimistic confirmation" guarantees
  ///   in release 1.3 and onwards.
  confirmed,

  /// The node will query the most recent block confirmed by supermajority
  /// of the cluster as having reached maximum lockout, meaning the cluster
  /// has recognized this block as finalized.
  finalized,
}

/// Extend the enum to get a valid string representation
/// of a commitment.
extension CommitmentValueExt on Commitment {
  String get value {
    switch (this) {
      case Commitment.processed:
        return 'processed';
      case Commitment.confirmed:
        return 'confirmed';
      case Commitment.finalized:
        return 'finalized';
    }
  }
}

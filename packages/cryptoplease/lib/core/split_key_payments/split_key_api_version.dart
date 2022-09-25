/// API version for the split key payment feature.
enum SplitKeyApiVersion {
  /// Transaction created using solana lib directly.
  v1,

  /// Transaction created using cryptoplease API to pay the fees in USDC.
  v2,
}

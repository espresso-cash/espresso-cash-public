/// API version for the split key payment feature
enum SplitKeyApiVersion {
  /// Transaction created using manual escrow transfers
  manual,

  /// Transaction created using a smart contract for escrow
  smartContract,
}

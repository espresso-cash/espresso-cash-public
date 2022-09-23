/// Method for the fee payment in direct transfer feature.
enum DirectPaymentFeeMethod {
  /// Transaction created using solana lib directly.
  v1,

  /// Transaction created using cryptoplease API to pay the fees in USDC.
  v2,
}

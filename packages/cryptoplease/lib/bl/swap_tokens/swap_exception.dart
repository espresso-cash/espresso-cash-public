enum SwapFailReason {
  routeNotFound,
  setupFailed,
  swapFailed,
  cleanUpFailed,
  unknown,
}

class SwapExcetion implements Exception {
  const SwapExcetion(
    this.reason, {
    this.exception,
  });

  final SwapFailReason reason;
  final Exception? exception;
}

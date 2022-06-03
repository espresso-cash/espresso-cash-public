enum SwapFailReason {
  routeNotFound,
  setupFailed,
  swapFailed,
  cleanUpFailed,
  unknown,
}

class SwapException implements Exception {
  const SwapException(
    this.reason, {
    this.exception,
  });

  final SwapFailReason reason;
  final Exception? exception;
}

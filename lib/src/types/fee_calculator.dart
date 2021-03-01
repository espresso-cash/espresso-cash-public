class FeeCalculator {
  FeeCalculator._(this.lamportsPerSignature) {
    if (lamportsPerSignature == null)
      throw ('`lamportsPerSignature\' must never be `null\'');
  }

  FeeCalculator.fromDynamic(dynamic source)
      : this._(source['lamportsPerSignature']);

  final int lamportsPerSignature;
}

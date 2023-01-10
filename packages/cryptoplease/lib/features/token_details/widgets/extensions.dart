extension PriceFormatExt on double? {
  String format({
    String? symbol,
    required int maxDecimals,
  }) {
    final price = this;

    if (price == null) return '-';

    final formatted = price < 0.01
        ? price.toStringAsFixed(maxDecimals)
        : price.toStringAsFixed(2);

    return '$symbol$formatted';
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_chart_item.freezed.dart';

@freezed
class TokenChartItem with _$TokenChartItem {
  const factory TokenChartItem({
    DateTime? date,
    double? price,
  }) = _TokenChartItem;

  const TokenChartItem._();
}

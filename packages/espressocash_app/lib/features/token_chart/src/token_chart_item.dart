import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_chart_item.freezed.dart';
part 'token_chart_item.g.dart';

@freezed
class TokenChartItem with _$TokenChartItem {
  const factory TokenChartItem({
    DateTime? date,
    double? price,
  }) = _TokenChartItem;

  const TokenChartItem._();

  factory TokenChartItem.fromJson(Map<String, dynamic> data) =>
      _$TokenChartItemFromJson(data);
}

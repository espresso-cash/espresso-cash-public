import 'package:json_annotation/json_annotation.dart';

part 'fee_calculator.g.dart';

@JsonSerializable(createToJson: false)
class FeeCalculator {
  FeeCalculator({this.lamportsPerSignature});

  factory FeeCalculator.fromJson(Map<String, dynamic> json) =>
      _$FeeCalculatorFromJson(json);

  final int lamportsPerSignature;
}

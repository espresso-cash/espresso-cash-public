part of 'decoder.dart';

@JsonSerializable(createToJson: false)
class FeeCalculator {
  FeeCalculator({required this.lamportsPerSignature});

  factory FeeCalculator.fromJson(Map<String, dynamic> json) =>
      _$FeeCalculatorFromJson(json);

  final int lamportsPerSignature;
}

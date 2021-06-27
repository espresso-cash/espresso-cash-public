part of 'rpc_client.dart';

/// Fee calculator object which is part of a [Blockhash] object.
@JsonSerializable(createToJson: false)
class FeeCalculator {
  FeeCalculator({required this.lamportsPerSignature});

  factory FeeCalculator.fromJson(Map<String, dynamic> json) =>
      _$FeeCalculatorFromJson(json);

  final int lamportsPerSignature;
}

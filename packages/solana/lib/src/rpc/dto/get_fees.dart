part of 'dto.dart';

@JsonSerializable(createToJson: false)
class GetFeesResponse {
  GetFeesResponse({
    required this.blockhash,
    required this.feeCalculator,
    required this.lastValidBlockHeight,
  });

  factory GetFeesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetFeesResponseFromJson(json);

  final String blockhash;
  final FeeCalculator feeCalculator;
  final int lastValidBlockHeight;
}

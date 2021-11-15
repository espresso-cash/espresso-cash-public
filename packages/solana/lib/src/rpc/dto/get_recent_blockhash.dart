part of 'dto.dart';

@JsonSerializable(createToJson: false)
class RecentBlockhash {
  RecentBlockhash({
    required this.blockhash,
    required this.feeCalculator,
  });

  factory RecentBlockhash.fromJson(Map<String, dynamic> json) =>
      _$RecentBlockhashFromJson(json);

  final String blockhash;
  final FeeCalculator feeCalculator;
}

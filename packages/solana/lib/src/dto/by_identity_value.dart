import 'package:freezed_annotation/freezed_annotation.dart';

part 'by_identity_value.g.dart';

@JsonSerializable(createToJson: false)
class ByIdentityValue {
  const ByIdentityValue({
    required this.leaderSlots,
    required this.blocksProduced,
  });

  factory ByIdentityValue.fromJson(dynamic data) {
    if (data is! List<int>) {
      throw const FormatException('expected an array with two integers');
    }

    return ByIdentityValue(
      leaderSlots: data[0],
      blocksProduced: data[1],
    );
  }

  Map<String, dynamic> toJson() {
    throw UnsupportedError('converting this object to json is not supported');
  }

  final int leaderSlots;
  final int blocksProduced;
}

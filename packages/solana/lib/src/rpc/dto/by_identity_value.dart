import 'package:freezed_annotation/freezed_annotation.dart';

part 'by_identity_value.g.dart';

@JsonSerializable(createToJson: false)
class ByIdentityValue {
  const ByIdentityValue({
    required this.leaderSlots,
    required this.blocksProduced,
  });

  factory ByIdentityValue.fromJson(dynamic data) {
    if (data is! List<dynamic>) {
      throw const FormatException('expected an array');
    }
    final integers = data.whereType<int>().toList(growable: false);
    if (integers.length != 2) {
      throw const FormatException('expected an array with two integers');
    }

    return ByIdentityValue(
      leaderSlots: integers[0],
      blocksProduced: integers[1],
    );
  }

  final int leaderSlots;
  final int blocksProduced;
}

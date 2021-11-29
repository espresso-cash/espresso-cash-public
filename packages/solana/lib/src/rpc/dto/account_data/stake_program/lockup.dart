import 'package:json_annotation/json_annotation.dart';

part 'lockup.g.dart';

@JsonSerializable()
class Lockup {
  const Lockup({
    required this.custodian,
    required this.epoch,
    required this.unixTimestamp,
  });

  factory Lockup.fromJson(Map<String, dynamic> json) => _$LockupFromJson(json);

  final String custodian;
  final int epoch;
  final int unixTimestamp;
}

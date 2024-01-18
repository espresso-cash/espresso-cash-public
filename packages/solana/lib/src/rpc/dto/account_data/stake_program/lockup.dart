import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/encoder/byte_array.dart';

part 'lockup.g.dart';

@JsonSerializable()
class Lockup {
  const Lockup({
    required this.custodian,
    required this.epoch,
    required this.unixTimestamp,
  });

  factory Lockup.fromJson(Map<String, dynamic> json) => _$LockupFromJson(json);

  const Lockup.none()
      : unixTimestamp = 0,
        epoch = 0,
        custodian = '11111111111111111111111111111111';

  ByteArray serialize() => ByteArray.merge([
        ByteArray.i64(unixTimestamp),
        ByteArray.u64(epoch),
        ByteArray.fromBase58(custodian),
      ]);

  final String custodian;
  final int epoch;
  final int unixTimestamp;

  Map<String, dynamic> toJson() => _$LockupToJson(this);
}

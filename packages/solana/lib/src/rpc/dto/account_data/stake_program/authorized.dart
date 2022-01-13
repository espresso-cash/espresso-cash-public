import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/encoder/buffer.dart';

part 'authorized.g.dart';

@JsonSerializable()
class Authorized {
  const Authorized({
    required this.staker,
    required this.withdrawer,
  });

  factory Authorized.fromJson(Map<String, dynamic> json) =>
      _$AuthorizedFromJson(json);

  ByteArray serialize() => Buffer.fromConcatenatedByteArrays([
        Buffer.fromBase58(staker),
        Buffer.fromBase58(withdrawer),
      ]);

  final String staker;
  final String withdrawer;
}

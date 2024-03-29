import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/encoder/byte_array.dart';

part 'authorized.g.dart';

@JsonSerializable()
class Authorized {
  const Authorized({
    required this.staker,
    required this.withdrawer,
  });

  factory Authorized.fromJson(Map<String, dynamic> json) =>
      _$AuthorizedFromJson(json);

  ByteArray serialize() => ByteArray.merge([
        ByteArray.fromBase58(staker),
        ByteArray.fromBase58(withdrawer),
      ]);

  final String staker;
  final String withdrawer;

  Map<String, dynamic> toJson() => _$AuthorizedToJson(this);
}

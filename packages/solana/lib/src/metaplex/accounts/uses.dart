import 'package:borsh_annotation/borsh_annotation.dart';

part 'uses.g.dart';

@BorshSerializable()
class Uses with _$Uses {
  factory Uses({
    @BU8() required int useMethod,
    @BU64() required BigInt remaining,
    @BU64() required BigInt total,
  }) = _Uses;

  const Uses._();

  factory Uses.fromBorsh(Uint8List data) => _$UsesFromBorsh(data);
}

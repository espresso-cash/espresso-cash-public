import 'package:borsh_annotation/borsh_annotation.dart';

part 'master_edition.g.dart';

@BorshSerializable()
abstract class MasterEdition with _$MasterEdition {
  factory MasterEdition({
    @BU8() required int key,
    @BU64() required BigInt supply,
    @BOption(BU64()) BigInt? maxSupply,
  }) = _MasterEdition;

  const MasterEdition._();

  factory MasterEdition.fromBorsh(Uint8List data) =>
      _$MasterEditionFromBorsh(data);
}

import 'dart:typed_data';

import 'package:borsh_annotation/borsh_annotation.dart';

part 'raw_mint.g.dart';

@Struct()
class RawMint extends BorshStruct {
  RawMint({
    required this.mintAuthorityOption,
    required this.mintAuthority,
    required this.supply,
    required this.decimals,
    required this.isInitialized,
    required this.freezeAuthorityOption,
    required this.freezeAuthority,
  });

  factory RawMint.fromBorsh(List<int> bytes) => _RawMintFromBorsh(bytes);

  @override
  List<int> toBorsh() => _RawMintToBorsh(this);

  @u32
  final int mintAuthorityOption;

  @Array.fixed(Borsh.u8, length: 32)
  final List<int> mintAuthority;

  @u64
  final int supply;

  @u8
  final int decimals;

  @u8
  final int isInitialized;

  @u32
  final int freezeAuthorityOption;

  @Array.fixed(Borsh.u8, length: 32)
  final List<int> freezeAuthority;
}

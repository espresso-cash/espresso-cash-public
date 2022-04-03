// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_mint.dart';

// **************************************************************************
// Borsh Struct Generator
// **************************************************************************

RawMint _RawMintFromBorsh(List<int> _data) {
  ByteData _view = ByteData.sublistView(Uint8List.fromList(_data));
  int offset = 0;

  final mintAuthorityOption = _view.readInteger(Borsh.u32, offset);
  offset += 4;

  final mintAuthority = _view.readFixedArray<int>(Borsh.u8, 32, offset);
  offset += mintAuthority.length * 1;

  final supply = _view.readInteger(Borsh.u64, offset);
  offset += 8;

  final decimals = _view.readInteger(Borsh.u8, offset);
  offset += 1;

  final isInitialized = _view.readInteger(Borsh.u8, offset);
  offset += 1;

  final freezeAuthorityOption = _view.readInteger(Borsh.u32, offset);
  offset += 4;

  final freezeAuthority = _view.readFixedArray<int>(Borsh.u8, 32, offset);
  offset += freezeAuthority.length * 1;

  return RawMint(
    mintAuthorityOption: mintAuthorityOption,
    mintAuthority: mintAuthority,
    supply: supply,
    decimals: decimals,
    isInitialized: isInitialized,
    freezeAuthorityOption: freezeAuthorityOption,
    freezeAuthority: freezeAuthority,
  );
}

List<int> _RawMintToBorsh(RawMint s) {
  int size = 0;
  size += s.mintAuthority.length * 1;
  size += s.freezeAuthority.length * 1;
  size += 18;

  final data = ByteData(size);
  int offset = 0;
  offset += data.writeInteger(Borsh.u32, offset, s.mintAuthorityOption);
  offset += data.writeFixedArray<int>(Borsh.u8, offset, s.mintAuthority);
  offset += data.writeInteger(Borsh.u64, offset, s.supply);
  offset += data.writeInteger(Borsh.u8, offset, s.decimals);
  offset += data.writeInteger(Borsh.u8, offset, s.isInitialized);
  offset += data.writeInteger(Borsh.u32, offset, s.freezeAuthorityOption);
  offset += data.writeFixedArray<int>(Borsh.u8, offset, s.freezeAuthority);

  return data.buffer.asUint8List();
}

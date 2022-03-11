// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata.dart';

// **************************************************************************
// Borsh Struct Generator
// **************************************************************************

MetadataData _MetadataDataFromBorsh(List<int> _data) {
  ByteData _view = ByteData.sublistView(Uint8List.fromList(_data));
  int offset = 0;

  final key = _view.readInteger(Borsh.u8, offset);
  offset += 1;

  final updateAuthority = _view.readFixedArray<int>(Borsh.u8, 32, offset);
  offset += updateAuthority.length * 1;

  final mint = _view.readFixedArray<int>(Borsh.u8, 32, offset);
  offset += mint.length * 1;

  final name = _view.readString(offset);
  offset += 4 + name.length;

  final symbol = _view.readString(offset);
  offset += 4 + symbol.length;

  final uri = _view.readString(offset);
  offset += 4 + uri.length;

  final sellerFeeBasisPoints = _view.readInteger(Borsh.u16, offset);
  offset += 2;

  return MetadataData(
    key: key,
    updateAuthority: updateAuthority,
    mint: mint,
    name: name,
    symbol: symbol,
    uri: uri,
    sellerFeeBasisPoints: sellerFeeBasisPoints,
  );
}

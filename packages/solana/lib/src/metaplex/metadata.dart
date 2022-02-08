import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:solana/base58.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/metaplex/off_chain_metadata.dart';

class Metadata {
  const Metadata({
    required this.name,
    required this.symbol,
    required this.uri,
    required this.updateAuthority,
    required this.mintAccount,
    required this.isMutable,
  });

  static Future<Metadata?> fromBinary(List<int> sourceBytes) async {
    final bytes = Int8List.fromList(sourceBytes);
    if (bytes.first != 0x04) {
      return null;
    }
    final reader = _StructReader(bytes.buffer)..skip(1);
    // This is performed in order for now, but it would be good to make
    // it order independent
    final updateAuthority = base58encode(reader.nextBytes(32));
    final mintAccount = base58encode(reader.nextBytes(32));

    final name = reader.nextString();
    final symbol = reader.nextString();
    final uri = reader.nextString();
    final isMutable = reader.nextBool();

    return Metadata(
      name: name,
      symbol: symbol,
      uri: uri,
      updateAuthority: updateAuthority,
      mintAccount: mintAccount,
      isMutable: isMutable,
    );
  }

  Future<OffChainMetadata> getExternalJson() async {
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode != 200) {
      throw HttpException(response.statusCode, response.body);
    }

    return OffChainMetadata.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );
  }

  final String name;
  final String symbol;
  final String uri;
  final String updateAuthority;
  final String mintAccount;
  final bool isMutable;
}

class _StructReader {
  _StructReader(this._buffer) : _offset = 0;

  void skip(int length) => _offset += length;

  String nextString() {
    final length = _buffer.asByteData(_offset, 4).getInt32(0, Endian.little);
    final rawBytes = _buffer.asUint8List(_offset + 4, length);

    _offset += length + 4;
    // It is a zero terminated string a'la C
    final lastZero = rawBytes.indexOf(0);
    if (lastZero == -1) {
      return '';
    }

    return utf8.decode(rawBytes.sublist(0, lastZero));
  }

  bool nextBool() {
    final value = _buffer.asByteData(_offset, 1).getInt8(0);
    _offset += 1;

    return value == 1;
  }

  int nextInt32() {
    final value = _buffer.asByteData(_offset, 2).getInt16(0, Endian.little);
    _offset += 2;

    return value;
  }

  int nextInt16() {
    final value = _buffer.asByteData(_offset, 4).getInt32(0, Endian.little);
    _offset += 4;

    return value;
  }

  Uint8List nextBytes(int length) {
    final bytes = _buffer.asUint8List(_offset, length);
    _offset += length;

    return bytes;
  }

  final ByteBuffer _buffer;
  int _offset;
}

const metaplexMetadataProgramId = 'metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s';

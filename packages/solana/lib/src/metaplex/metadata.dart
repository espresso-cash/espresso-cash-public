import 'dart:convert';
import 'dart:typed_data';

import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:solana/base58.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/metaplex/off_chain_metadata.dart';

part 'metadata.g.dart';

@Struct(createToBorsh: false)
class MetadataData {
  MetadataData({
    required this.key,
    required this.updateAuthority,
    required this.mint,
    required this.name,
    required this.symbol,
    required this.uri,
    required this.sellerFeeBasisPoints,
  });

  factory MetadataData.fromBorsh(List<int> bytes) =>
      _MetadataDataFromBorsh(bytes);

  @u8
  final int key;

  @Array.fixed(Borsh.u8, length: 32)
  final List<int> updateAuthority;

  @Array.fixed(Borsh.u8, length: 32)
  final List<int> mint;

  @string
  final String name;

  @string
  final String symbol;

  @string
  final String uri;

  @u16
  final int sellerFeeBasisPoints;
}

class Metadata {
  const Metadata({
    required this.name,
    required this.symbol,
    required this.uri,
    required this.updateAuthority,
    required this.mintAccount,
  });

  factory Metadata.fromBinary(List<int> sourceBytes) {
    final data = MetadataData.fromBorsh(sourceBytes);

    return Metadata(
      name: data.name,
      symbol: data.symbol,
      uri: data.uri,
      updateAuthority: base58encode(data.updateAuthority),
      mintAccount: base58encode(data.mint),
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
}

const metaplexMetadataProgramId = 'metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s';

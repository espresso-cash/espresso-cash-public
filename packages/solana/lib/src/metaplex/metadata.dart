import 'dart:convert';

import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:solana/metaplex.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/borsh_ext.dart';
import 'package:solana/src/metaplex/collection_details.dart';
import 'package:solana/src/metaplex/creator.dart';
import 'package:solana/src/metaplex/on_chain_collection.dart';
import 'package:solana/src/metaplex/uses.dart';

part 'metadata.g.dart';

@BorshSerializable()
class Metadata with _$Metadata {
  factory Metadata({
    @BU8() required int key,
    @BPublicKey() required Ed25519HDPublicKey updateAuthority,
    @BPublicKey() required Ed25519HDPublicKey mint,
    @BString() required String name,
    @BString() required String symbol,
    @BString() required String uri,
    @BU16() required int sellerFeeBasisPoints,
    @BOption(BArray(BCreator())) required List<Creator>? creators,
    @BBool() required bool primarySaleHappened,
    @BBool() required bool isMutable,
    @BOption(BU8()) required int? editionNonce,
    @BOption(BU8()) required int? tokenStandard,
    @BOption(BOnChainCollection()) required OnChainCollection? collection,
    @BOption(BUses()) required Uses? uses,
    @BOption(BCollectionDetails())
        required CollectionDetails? collectionDetails,
  }) = _Metadata;

  const Metadata._();

  factory Metadata.fromBorsh(Uint8List data) => _$MetadataFromBorsh(data);

  Future<OffChainMetadata> getExternalJson() async {
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode != 200) {
      throw HttpException(response.statusCode, response.body);
    }

    return OffChainMetadata.fromJson(
      json.decode(response.body) as Map<String, dynamic>,
    );
  }
}

const metaplexMetadataProgramId = 'metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s';

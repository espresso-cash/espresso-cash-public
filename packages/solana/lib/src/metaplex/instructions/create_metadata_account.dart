import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/anchor.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/metaplex/instructions/fixed_string.dart';
import 'package:solana/src/metaplex/utils.dart';

part 'create_metadata_account.g.dart';

Future<AnchorInstruction> createMetadataAccountV3({
  required Ed25519HDPublicKey mint,
  required Ed25519HDPublicKey mintAuthority,
  required Ed25519HDPublicKey payer,
  required Ed25519HDPublicKey updateAuthority,
  required CreateMetadataAccountV3Data data,
}) async {
  final programAddress = await findMetaplexMetadataProgramAddress(mint);

  return AnchorInstruction.withDiscriminator(
    discriminator: ByteArray(const [33]),
    programId: Ed25519HDPublicKey.fromBase58(metaplexMetadataProgramId),
    accounts: [
      AccountMeta.writeable(pubKey: programAddress, isSigner: false),
      AccountMeta.readonly(pubKey: mint, isSigner: false),
      AccountMeta.readonly(pubKey: mintAuthority, isSigner: true),
      AccountMeta.writeable(pubKey: payer, isSigner: true),
      AccountMeta.readonly(pubKey: updateAuthority, isSigner: false),
      AccountMeta.readonly(pubKey: SystemProgram.id, isSigner: false),
      AccountMeta.readonly(
        pubKey: Ed25519HDPublicKey.fromBase58(Sysvar.rent),
        isSigner: false,
      ),
    ],
    arguments: ByteArray(data.toBorsh()),
  );
}

@BorshSerializable()
abstract class CreateMetadataAccountV3Data with _$CreateMetadataAccountV3Data {
  factory CreateMetadataAccountV3Data({
    @BFixedString(32) required String name,
    @BFixedString(10) required String symbol,
    @BFixedString(200) required String uri,
    @BU16() required int sellerFeeBasisPoints,
    @BOption(BArray(BMetadataCreator())) List<MetadataCreator>? creators,
    @BOption(BMetadataCollection()) MetadataCollection? collection,
    @BOption(BMetadataUses()) MetadataUses? uses,
    @BBool() required bool isMutable,
    @BBool() required bool colectionDetails,
  }) = _CreateMetadataAccountV3Data;

  const CreateMetadataAccountV3Data._();

  factory CreateMetadataAccountV3Data.fromBorsh(Uint8List data) =>
      _$CreateMetadataAccountV3DataFromBorsh(data);
}

@BorshSerializable()
abstract class MetadataCreator with _$MetadataCreator {
  factory MetadataCreator({
    @BPublicKey() required Ed25519HDPublicKey address,
    @BBool() required bool verified,
    @BU8() required int share,
  }) = _MetadataCreator;

  const MetadataCreator._();

  factory MetadataCreator.fromBorsh(Uint8List data) =>
      _$MetadataCreatorFromBorsh(data);
}

@BorshSerializable()
abstract class MetadataCollection with _$MetadataCollection {
  factory MetadataCollection({
    @BBool() required bool verified,
    @BPublicKey() required Ed25519HDPublicKey key,
  }) = _MetadataCollection;

  const MetadataCollection._();

  factory MetadataCollection.fromBorsh(Uint8List data) =>
      _$MetadataCollectionFromBorsh(data);
}

@BorshSerializable()
abstract class MetadataUses with _$MetadataUses {
  factory MetadataUses({
    @BU8() required int useMethod,
    @BU64() required BigInt remaining,
    @BU64() required BigInt total,
  }) = _MetadataUses;

  const MetadataUses._();

  factory MetadataUses.fromBorsh(Uint8List data) =>
      _$MetadataUsesFromBorsh(data);
}

import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/anchor.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/metaplex/utils.dart';

part 'create_master_edition.g.dart';

Future<AnchorInstruction> createMasterEditionV3({
  required Ed25519HDPublicKey mint,
  required Ed25519HDPublicKey updateAuthority,
  required Ed25519HDPublicKey mintAuthority,
  required Ed25519HDPublicKey payer,
  required CreateMasterEditionV3Data data,
}) async {
  final programAddress = await findMetaplexEditionProgramAddress(mint);
  final metadataAccount = await findMetaplexMetadataProgramAddress(mint);

  return AnchorInstruction.withDiscriminator(
    programId: Ed25519HDPublicKey.fromBase58(metaplexMetadataProgramId),
    discriminator: ByteArray(const [17]),
    accounts: [
      AccountMeta.writeable(pubKey: programAddress, isSigner: false),
      AccountMeta.writeable(pubKey: mint, isSigner: false),
      AccountMeta.readonly(pubKey: updateAuthority, isSigner: true),
      AccountMeta.readonly(pubKey: mintAuthority, isSigner: true),
      AccountMeta.writeable(pubKey: payer, isSigner: true),
      AccountMeta.writeable(pubKey: metadataAccount, isSigner: false),
      AccountMeta.readonly(pubKey: TokenProgram.id, isSigner: false),
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
abstract class CreateMasterEditionV3Data with _$CreateMasterEditionV3Data {
  factory CreateMasterEditionV3Data({
    @BOption(BU64()) BigInt? maxSupply,
  }) = _CreateMasterEditionV3Data;

  const CreateMasterEditionV3Data._();

  factory CreateMasterEditionV3Data.fromBorsh(Uint8List data) =>
      _$CreateMasterEditionV3DataFromBorsh(data);
}

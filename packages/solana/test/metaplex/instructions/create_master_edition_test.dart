import 'package:solana/metaplex.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../../config.dart';

Future<void> main() async {
  const uri = 'https://arweave.net/LogULMuEjDSOg-TnsboIF6UvmZyyr6j3BDCN4p46Frc';
  const name = 'Cofre #514';
  const symbol = 'COFR';

  final client = createTestSolanaClient();
  final owner = await Ed25519HDKeyPair.random();

  test(
    'creates master edition',
    () async {
      await client.requestAirdrop(
        address: owner.publicKey,
        lamports: 1 * lamportsPerSol,
        commitment: Commitment.confirmed,
      );
      final mint = await client.initializeMint(
        mintAuthority: owner,
        freezeAuthority: owner.publicKey,
        decimals: 0,
        commitment: Commitment.confirmed,
      );
      await client.createAssociatedTokenAccount(
        mint: mint.address,
        funder: owner,
        commitment: Commitment.confirmed,
      );
      await client.mintTo(
        mint: mint.address,
        destination: await findAssociatedTokenAddress(
          owner: owner.publicKey,
          mint: mint.address,
        ),
        amount: 1,
        authority: owner,
        commitment: Commitment.confirmed,
      );

      final data = CreateMetadataAccountV3Data(
        name: name,
        symbol: symbol,
        uri: uri,
        sellerFeeBasisPoints: 550,
        isMutable: false,
        colectionDetails: false,
      );
      final instruction = await createMetadataAccountV3(
        mint: mint.address,
        mintAuthority: owner.publicKey,
        payer: owner.publicKey,
        updateAuthority: owner.publicKey,
        data: data,
      );

      final message = Message.only(instruction);

      await client.sendAndConfirmTransaction(
        message: message,
        signers: [owner],
        commitment: Commitment.confirmed,
      );

      final dataMaster = CreateMasterEditionV3Data(maxSupply: BigInt.zero);
      final instructionMaster = await createMasterEditionV3(
        mint: mint.address,
        updateAuthority: owner.publicKey,
        mintAuthority: owner.publicKey,
        payer: owner.publicKey,
        data: dataMaster,
      );

      final messageMaster = Message.only(instructionMaster);

      await client.sendAndConfirmTransaction(
        message: messageMaster,
        signers: [owner],
        commitment: Commitment.confirmed,
      );

      final masterEdition = await client.rpcClient.getMasterEdition(
        mint: mint.address,
        commitment: Commitment.confirmed,
      );

      expect(masterEdition?.supply, BigInt.zero);
      expect(masterEdition?.maxSupply, BigInt.zero);
    },
  );
}

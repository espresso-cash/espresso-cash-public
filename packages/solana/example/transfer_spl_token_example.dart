import 'package:solana/solana.dart';
import 'package:solana/src/solana_client/solana_client.dart';

Future<void> example() async {
  final rpcClient = SolanaClient(
    rpcUrl: _rpcUrl,
    websocketUrl: _websocketUrl,
  );

  // Create a wallet
  final source = Wallet(
    signer: await Ed25519HDKeyPair.random(),
    client: rpcClient,
  );

  // Because this is an example, let's put some lamports into the source
  // wallet. Note that this will of course not work on the main network.
  await source.requestAirdrop(lamports: 5);

  // Final Destination (so funny :D)
  final destination = Wallet(
    signer: await Ed25519HDKeyPair.random(),
    client: rpcClient,
  );

  // Both the sender, and recipient must have an associated token account
  await source.createAssociatedTokenAccount(mint: _tokenMint);
  // The associated token account can be funded but someone else
  await destination.createAssociatedTokenAccount(
    // Pay for the allocation of the account
    funder: source,
    mint: _tokenMint,
  );

  // Create a wallet to pay for fees
  final feePayer = Wallet(
    signer: await Ed25519HDKeyPair.random(),
    client: rpcClient,
  );
  // Add some tokens to pay for fees
  await feePayer.requestAirdrop(lamports: 10 * lamportsPerSol);

  final sourceAssociatedTokenAddress =
      await source.getAssociatedTokenAccountAddress(mint: _tokenMint);
  final destinationAssociatedTokenAddress =
      await destination.getAssociatedTokenAccountAddress(mint: _tokenMint);

  // Send to the newly created account
  final message = TokenProgram.transfer(
    source: sourceAssociatedTokenAddress,
    destination: destinationAssociatedTokenAddress,
    amount: 1000000,
    owner: source.address,
  );

  // In order for another account to pay for the fees, we must make it
  // the first signer in the following call.
  final signature = await rpcClient.signAndSendTransaction(
    message,
    <Ed25519HDKeyPair>[
      feePayer.signer,
      source.signer,
    ],
  );
  await rpcClient.waitForSignatureStatus(
    signature,
    ConfirmationStatus.finalized,
  );

  print('Transfer ($signature)');
  print('');
  print('amount   : 1.00 USDT');
  print('from     : $sourceAssociatedTokenAddress (${source.address})');
  print(
      'to       : $destinationAssociatedTokenAddress (${destination.address})');
  print('fee payer: ${feePayer.address}');
}

const _rpcUrl = 'https://api.devnet.solana.com';
const _websocketUrl = 'wss://api.devnet.solana.com';
// USDT token mint from (https://github.com/solana-labs/token-list/blob/main/src/tokens/solana.tokenlist.json);
const _tokenMint = 'Es9vMFrzaCERmJfrF4H2FYD4KCoNkY11McCe8BenwNYB';

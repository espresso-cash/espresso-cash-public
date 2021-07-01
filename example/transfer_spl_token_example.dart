import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/rpc_client/rpc_client.dart';
import 'package:solana/src/wallet.dart';

Future<void> example() async {
  final rpcClient = RPCClient(_rpcClientUrl);
  // Create a wallet
  final source = Wallet(
    signer: await Ed25519HDKeyPair.random(),
    rpcClient: rpcClient,
  );

  // Because this is an example, let's put some lamports into the source
  // wallet. Note that this will of course not work on the main network.
  await source.requestAirdrop(lamports: 5);

  // Final Destination (so funny :D)
  final destination = Wallet(
    signer: await Ed25519HDKeyPair.random(),
    rpcClient: rpcClient,
  );

  // Both the sender, and recipient must have an associated token account
  await source.createAssociatedTokenAccount(mint: _tokenMint);
  // The associated token account can be funded but someone else
  await destination.createAssociatedTokenAccount(
    // Pay for the allocation of the account
    funder: source,
    mint: _tokenMint,
  );

  // Finally transfer the tokens to the recipient
  await source.transferSplToken(
    mint: _tokenMint,
    destination: destination.address,
    amount: 1,
  );

  // Compute the fee that source payed
  final fee = 5 - await source.getLamports();

  print('You payed $fee lamports for the network fees');

  // To confirm that it worked let's see if there's any balance
  // in the recipients wallet
  final balance = await rpcClient.getTokenAccountBalance(
    associatedTokenAccountAddress:
        destination.getAssociatedTokenAccountAddress(mint: _tokenMint),
  );

  if (balance.amount == '1') {
    print('Good, it worked.');
  } else {
    print('Bad, it failed.');
  }
}

const _rpcClientUrl = 'https://api.devnet.solana.com';
// USDT token mint from (https://github.com/solana-labs/token-list/blob/main/src/tokens/solana.tokenlist.json);
const _tokenMint = 'Es9vMFrzaCERmJfrF4H2FYD4KCoNkY11McCe8BenwNYB';

import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

Future<Ed25519HDPublicKey> createAccount({
  required SolanaClient client,
  required Ed25519HDKeyPair owner,
  required Mint mint,
}) async {
  final accountKeyPair = await Ed25519HDKeyPair.random();

  await client.createTokenAccount(
    mint: mint.address,
    account: accountKeyPair,
    creator: owner,
    commitment: Commitment.confirmed,
  );

  return accountKeyPair.publicKey;
}

Future<TokenAmount?> getTokenAccountBalance({
  required SolanaClient client,
  required Ed25519HDPublicKey account,
}) async {
  final info = await client.rpcClient.getAccountInfo(
    account.toBase58(),
    encoding: Encoding.jsonParsed,
    commitment: Commitment.confirmed,
  );

  final accountData = info.value?.data;

  if (accountData is ParsedAccountData) {
    return accountData.maybeWhen(
      splToken: (parsed) => parsed.maybeMap(
        account: (a) => a.info.tokenAmount,
        orElse: () => null,
      ),
      orElse: () => null,
    );
  }

  return null;
}

Future<TokenAmount?> getTokenTest({
  required SolanaClient client,
  required Ed25519HDPublicKey account,
  required Ed25519HDPublicKey mint,
}) async =>
    client.getTokenBalance(owner: account, mint: mint);

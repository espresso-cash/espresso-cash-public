// ignore_for_file: deprecated_member_use

import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

class Accounts {
  Accounts({
    required this.escrowAccount,
    required this.receiverAccount,
    required this.senderTokenAccount,
    required this.vaultTokenAccount,
    required this.senderAccount,
    required this.depositorAccount,
    required this.receiverTokenAccount,
  });
  final Ed25519HDKeyPair escrowAccount;
  final Ed25519HDKeyPair receiverAccount;
  final Ed25519HDKeyPair senderAccount;
  final Ed25519HDKeyPair depositorAccount;
  final Ed25519HDPublicKey senderTokenAccount;
  final Ed25519HDPublicKey receiverTokenAccount;
  final Ed25519HDPublicKey vaultTokenAccount;
}

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

extension SignedTxExt on SignedTx {
  Future<SignedTx> resign(
    Ed25519HDKeyPair wallet,
  ) async =>
      SignedTx(
        signatures: signatures.toList()
          ..setAll(
              signatures.indexWhere((it) => it.publicKey == wallet.publicKey), [
            await wallet.sign(compiledMessage.toByteArray()),
          ]),
        compiledMessage: compiledMessage,
      );
}

import 'package:flutter/foundation.dart';
import 'package:solana/solana.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

abstract class ECWallet {
  const ECWallet();

  String get address;

  Ed25519HDPublicKey get publicKey;

  Future<List<Signature>> sign(Iterable<Uint8List> payloads);
}

class LocalWallet implements ECWallet {
  const LocalWallet(this.keyPair);

  final Ed25519HDKeyPair keyPair;

  @override
  String get address => keyPair.address;

  @override
  Ed25519HDPublicKey get publicKey => keyPair.publicKey;

  @override
  Future<List<Signature>> sign(Iterable<Uint8List> payloads) =>
      Future.wait(payloads.map(keyPair.sign));
}

class SagaWallet implements ECWallet {
  const SagaWallet(this.account, this.token);

  final Account account;
  final AuthToken token;

  @override
  String get address => account.publicKeyEncoded;

  @override
  Ed25519HDPublicKey get publicKey => Ed25519HDPublicKey(account.publicKeyRaw);

  @override
  Future<List<Signature>> sign(Iterable<Uint8List> payloads) async {
    final responses = await SeedVault.instance.signTransactions(
      authToken: token,
      signingRequests: payloads
          .map(
            (it) => SigningRequest(
              payload: it,
              requestedSignatures: [account.derivationPath],
            ),
          )
          .toList(),
    );

    return responses
        .map((it) => Signature(it.signatures.first, publicKey: publicKey))
        .toList();
  }
}

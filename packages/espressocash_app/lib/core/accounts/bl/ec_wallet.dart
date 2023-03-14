import 'dart:typed_data';

import 'package:solana/solana.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

abstract class ECWallet {
  String get address;

  Ed25519HDPublicKey get publicKey;

  Future<Signature> sign(Iterable<int> data);
}

class LocalWallet implements ECWallet {
  LocalWallet(this.keyPair, {this.wallet});

  final Ed25519HDKeyPair keyPair;
  final HDWallet? wallet;

  @override
  String get address => keyPair.address;

  @override
  Ed25519HDPublicKey get publicKey => keyPair.publicKey;

  @override
  Future<Signature> sign(Iterable<int> data) => keyPair.sign(data);
}

class SagaWallet implements ECWallet {
  SagaWallet(this.account, this.token);

  final Account account;
  final AuthToken token;

  @override
  String get address => account.publicKeyEncoded;

  @override
  Ed25519HDPublicKey get publicKey => Ed25519HDPublicKey(account.publicKeyRaw);

  @override
  Future<Signature> sign(Iterable<int> data) async {
    final response = await SeedVault.instance.signTransactions(
      authToken: token,
      signingRequests: [
        SigningRequest(
          payload: Uint8List.fromList(data.toList()),
          requestedSignatures: [account.derivationPath],
        ),
      ],
    );

    return Signature(response.first.signatures.first, publicKey: publicKey);
  }
}

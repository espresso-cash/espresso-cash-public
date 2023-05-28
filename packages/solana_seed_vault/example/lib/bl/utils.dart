// ignore_for_file: cast_nullable_to_non_nullable

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

Future<List<Ed25519HDPublicKey>> getPublicKeysFromPaths(
  AuthToken authToken,
  List<Uri> derivationPaths,
) async =>
    Future.wait(
      derivationPaths.map(
        (it) => SeedVault.instance
            .getAccounts(
              authToken: authToken,
              projection: [WalletContractV1.accountsPublicKeyRaw],
              filterOnColumn: WalletContractV1.accountsBip32DerivationPath,
              value: it.toString(),
            )
            .letAsync(
              (it) => it.singleOrNull?.let(
                (it) => it[WalletContractV1.accountsPublicKeyRaw] as Uint8List,
              ),
            )
            .letAsync(
              (it) => it?.let(Ed25519HDPublicKey.new),
            ),
      ),
    ).letAsync((it) => it.compact().toList());

Uint8List generateFakeMessage(List<String> signers) {
  final publicKeys = signers.map(Ed25519HDPublicKey.fromBase58).toList();

  return MemoInstruction(
    signers: publicKeys,
    memo: 'Memo #',
  )
      .let(Message.only)
      .let(
        (it) => it
            .compile(recentBlockhash: '', feePayer: publicKeys.first)
            .toByteArray()
            .toList(),
      )
      .let(Uint8List.fromList);
}

Uint8List generateFakeTransaction(List<String> signers) {
  final publicKeys = signers.map(Ed25519HDPublicKey.fromBase58).toList();

  return MemoInstruction(signers: publicKeys, memo: 'Memo #')
      .let(Message.only)
      .let(
        (it) => SignedTx(
          compiledMessage: it.compile(
            recentBlockhash: '',
            feePayer: publicKeys.first,
          ),
          signatures: publicKeys
              .map((it) => Signature(List.filled(64, 0), publicKey: it))
              .toList(),
        ),
      )
      .let((it) => it.toByteArray().toList().let(Uint8List.fromList));
}

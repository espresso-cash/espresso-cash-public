import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

Future<List<Ed25519HDPublicKey>> getPublicKeysFromPaths(
  AuthToken authToken,
  List<Uri> derivationPaths,
) async =>
    Future.wait(
      derivationPaths.map(
        (it) => SeedVaultWallet.instance
            .getAccounts(
              authToken,
              filter: AccountFilter.byDerivationPath(it),
            )
            .letAsync(
              (it) => it
                  .whenOrNull(
                    success: (it) => it.singleOrNull?.publicKeyEncoded,
                  )
                  ?.let(base58decode)
                  .let(Ed25519HDPublicKey.new),
            ),
      ),
    ).letAsync((it) => it.compact().toList());

Uint8List generateFakeMessage(List<String> signers) => MemoInstruction(
      signers: signers.map(Ed25519HDPublicKey.fromBase58).toList(),
      memo: 'Memo #',
    )
        .let(Message.only)
        .let((it) => it.compile(recentBlockhash: '').data.toList())
        .let(Uint8List.fromList);

Uint8List generateFakeTransaction(List<String> signers) {
  final publicKeys = signers.map(Ed25519HDPublicKey.fromBase58).toList();

  return MemoInstruction(signers: publicKeys, memo: 'Memo #')
      .let(Message.only)
      .let(
        (it) => SignedTx(
          messageBytes: it.compile(recentBlockhash: '').data,
          signatures: publicKeys
              .map(
                (it) => Signature(List.filled(64, 0), publicKey: it),
              )
              .toList(),
        ),
      )
      .let((it) => it.messageBytes.toList().let(Uint8List.fromList));
}

// ignore_for_file: deprecated_member_use

import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

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

import 'dart:typed_data';

import 'package:dfunc/dfunc.dart';
import 'package:solana/encoder.dart';

import '../accounts/bl/ec_wallet.dart';

extension ResignTx on SignedTx {
  Future<SignedTx> resign(ECWallet wallet) async =>
      [this].resignAll(wallet).then((it) => it.first);
}

extension ResignMultipleTx on Iterable<SignedTx> {
  Future<List<SignedTx>> resignAll(ECWallet wallet) async {
    final payloads = this.map(
      (it) => it.compiledMessage
          .toByteArray()
          .let((it) => it.toList())
          .let(Uint8List.fromList),
    );
    final signatures = await wallet.sign(payloads);

    return zip2(this, signatures).map(
      (it) {
        final tx = it.$1;
        final signature = it.$2;

        return SignedTx(
          signatures: tx.signatures
              .map((e) => e.publicKey == wallet.publicKey ? signature : e)
              .toList(),
          compiledMessage: tx.compiledMessage,
        );
      },
    ).toList();
  }
}

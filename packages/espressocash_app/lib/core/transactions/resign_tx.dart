import 'package:solana/encoder.dart';

import '../accounts/bl/ec_wallet.dart';

extension ResignTx on SignedTx {
  Future<SignedTx> resign(ECWallet wallet) async => SignedTx(
        signatures: signatures.toList()
          ..setAll(
              signatures.indexWhere((it) => it.publicKey == wallet.publicKey), [
            await wallet.sign(compiledMessage.toByteArray()),
          ]),
        compiledMessage: compiledMessage,
      );
}

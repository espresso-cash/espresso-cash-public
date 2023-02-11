import 'package:solana/encoder.dart';

import '../accounts/bl/ec_wallet.dart';

extension ResignTx on SignedTx {
  Future<SignedTx> resign(ECWallet wallet) async => SignedTx(
        signatures: signatures.toList()
          ..removeLast()
          ..add(await wallet.sign(compiledMessage.toByteArray())),
        compiledMessage: compiledMessage,
      );
}

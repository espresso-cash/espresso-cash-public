import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

extension ResignTx on SignedTx {
  Future<SignedTx> resign(Wallet wallet) async => SignedTx(
        signatures: signatures.toList()
          ..removeLast()
          ..add(await wallet.sign(messageBytes)),
        messageBytes: messageBytes,
      );
}

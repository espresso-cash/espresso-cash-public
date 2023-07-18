import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

extension SignedTxExt on SignedTx {
  Future<SignedTx> resign(Ed25519HDKeyPair wallet) async {
    final signature = await wallet.sign(compiledMessage.toByteArray());

    return SignedTx(
      signatures: signatures
          .map((e) => e.publicKey == wallet.publicKey ? signature : e)
          .toList(),
      compiledMessage: compiledMessage,
    );
  }
}

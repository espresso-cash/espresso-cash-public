import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/payments/create_direct_payment.dart';
import 'package:dfunc/dfunc.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

Future<SignedTx> createSwap({
  required String encodedTx,
  required int swapFees,
  required Ed25519HDKeyPair platform,
  required Ed25519HDPublicKey aSender,
  required SolanaClient client,
  required Commitment commitment,
}) async {
  final feePaymentTx = await createDirectPayment(
    aSender: aSender,
    aReceiver: platform.publicKey,
    mint: mainnetUsdc,
    amount: swapFees,
    platform: platform,
    client: client,
    commitment: commitment,
    aReference: null,
  );

  final message = encodedTx
      .let(SignedTx.decode)
      .let((tx) => tx.message)
      .let((message) => message.changeAtaIxsFunder(platform.publicKey))
      .let((message) => message.merge(feePaymentTx.transaction.message));

  final recentBlockhash = await client.rpcClient.getRecentBlockhash();
  final compiled = message.compile(
    recentBlockhash: recentBlockhash.blockhash,
    feePayer: platform.publicKey,
  );

  return SignedTx(
    messageBytes: compiled.data,
    signatures: [
      await platform.sign(compiled.data),
      Signature(List.filled(64, 0), publicKey: aSender),
    ],
  );
}

extension on Message {
  Message changeAtaIxsFunder(Ed25519HDPublicKey funder) {
    final instructions = this.instructions.map(
      (ix) {
        if (ix.programId != AssociatedTokenAccountProgram.id) return ix;

        return ix.also(
          (ix) => ix.accounts
            ..removeAt(0)
            ..insert(0, AccountMeta.writeable(pubKey: funder, isSigner: true)),
        );
      },
    );

    return Message(instructions: instructions.toList());
  }

  Message merge(Message other) => Message(
        instructions: [
          ...instructions,
          ...other.instructions,
        ],
      );
}

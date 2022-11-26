import 'package:cryptoplease_link/src/swap/create_swap_fee_payment.dart';
import 'package:dfunc/dfunc.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

Future<SignedTx> createSwap({
  required String encodedTx,
  required Ed25519HDKeyPair platform,
  required Ed25519HDPublicKey aSender,
  required SolanaClient client,
  required Commitment commitment,
  required int feeAmount,
}) async {
  final feePayer = platform.publicKey;
  final feeMessage = await createSwapFeePaymentMessage(
    aSender: aSender,
    aReceiver: feePayer,
    amount: feeAmount,
  );

  final message = encodedTx
      .let(SignedTx.decode)
      .let((tx) => tx.message)
      .let((message) => message.changeAtaIxsFunder(platform.publicKey))
      .let((message) => message.merge(feeMessage));

  final recentBlockhash = await client.rpcClient.getRecentBlockhash(
    commitment: commitment,
  );
  final compiled = message.compile(
    recentBlockhash: recentBlockhash.blockhash,
    feePayer: feePayer,
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

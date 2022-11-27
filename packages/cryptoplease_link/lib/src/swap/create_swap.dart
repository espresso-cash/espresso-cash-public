import 'package:cryptoplease_link/src/constants.dart';
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
  final feeIx = await _createSwapFeePayment(
    aSender: aSender,
    aReceiver: feePayer,
    amount: feeAmount,
  );

  final message = encodedTx
      .let(SignedTx.decode)
      .let((tx) => tx.message)
      .let((message) => message.changeAtaIxsFunder(platform.publicKey))
      .let((message) => message.addInstruction(feeIx));

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
    final instructions = this.instructions.map((ix) {
      if (ix.programId != AssociatedTokenAccountProgram.id) return ix;

      return Instruction(
        programId: ix.programId,
        accounts: [
          AccountMeta.writeable(pubKey: funder, isSigner: true),
          ...ix.accounts.skip(1),
        ],
        data: ix.data,
      );
    }).toList();

    return Message(instructions: instructions);
  }

  Message addInstruction(Instruction ix) =>
      Message(instructions: [...instructions, ix]);
}

Future<Instruction> _createSwapFeePayment({
  required Ed25519HDPublicKey aReceiver,
  required Ed25519HDPublicKey aSender,
  required int amount,
}) async {
  // Swap fee is always paid in mainnet USDC
  final mint = mainnetUsdc;

  final ataSender = await findAssociatedTokenAddress(
    owner: aSender,
    mint: mint,
  );

  final ataReceiver = await findAssociatedTokenAddress(
    owner: aReceiver,
    mint: mint,
  );

  return TokenInstruction.transfer(
    amount: amount,
    source: ataSender,
    destination: ataReceiver,
    owner: aSender,
  );
}

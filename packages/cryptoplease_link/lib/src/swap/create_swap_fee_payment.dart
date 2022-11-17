import 'package:cryptoplease_link/src/constants.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

Future<Message> createSwapFeePaymentMessage({
  required SolanaClient client,
  required Ed25519HDPublicKey aReceiver,
  required Ed25519HDPublicKey aSender,
  required Commitment commitment,
}) async {
  // Swap fee is always paid in mainnet USDC
  final mint = mainnetUsdc;
  const amount = swapFee;

  final shouldCreateAta = !await client.hasAssociatedTokenAccount(
    owner: aReceiver,
    mint: mint,
    commitment: commitment,
  );

  final instructions = <Instruction>[];

  final ataSender = await findAssociatedTokenAddress(
    owner: aSender,
    mint: mint,
  );

  final ataReceiver = await findAssociatedTokenAddress(
    owner: aReceiver,
    mint: mint,
  );

  if (shouldCreateAta) {
    final iCreateATA = AssociatedTokenAccountInstruction.createAccount(
      funder: aReceiver,
      address: ataReceiver,
      owner: aReceiver,
      mint: mint,
    );
    instructions.add(iCreateATA);
  }

  final iTransfer = TokenInstruction.transfer(
    amount: amount,
    source: ataSender,
    destination: ataReceiver,
    owner: aSender,
  );

  instructions.add(iTransfer);

  return Message(instructions: instructions);
}

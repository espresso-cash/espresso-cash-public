import 'package:cryptoplease_link/src/constants.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

Future<Message> createSwapFeePaymentMessage({
  required Ed25519HDPublicKey aReceiver,
  required Ed25519HDPublicKey aSender,
  required int amount,
}) async {
  // Swap fee is always paid in mainnet USDC
  final mint = mainnetUsdc;

  final instructions = <Instruction>[];

  final ataSender = await findAssociatedTokenAddress(
    owner: aSender,
    mint: mint,
  );

  final ataReceiver = await findAssociatedTokenAddress(
    owner: aReceiver,
    mint: mint,
  );

  final iTransfer = TokenInstruction.transfer(
    amount: amount,
    source: ataSender,
    destination: ataReceiver,
    owner: aSender,
  );

  instructions.add(iTransfer);

  return Message(instructions: instructions);
}

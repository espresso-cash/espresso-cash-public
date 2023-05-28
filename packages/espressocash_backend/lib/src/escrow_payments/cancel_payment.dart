import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/escrow_payments/instructions.dart';
import 'package:espressocash_backend/src/payments/escrow_account.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

Future<Product2<SignedTx, BigInt>> cancelPaymentTx({
  required Ed25519HDPublicKey aEscrow,
  required Ed25519HDPublicKey aSender,
  required Ed25519HDPublicKey mint,
  required Ed25519HDKeyPair platform,
  required SolanaClient client,
  required Commitment commitment,
}) async {
  final escrow = await tryFetchEscrow(
    address: aEscrow,
    platform: platform,
    mint: mint,
    client: client,
    commitment: commitment,
  );

  if (escrow == null) {
    throw const EspressoCashException(
      error: EspressoCashError.invalidEscrowAccount,
    );
  }

  final ataSender = await findAssociatedTokenAddress(
    owner: aSender,
    mint: mint,
  );

  final ataEscrow = await findAssociatedTokenAddress(
    owner: aEscrow,
    mint: mint,
  );

  final escrowIx = await EscrowInstruction.cancelEscrow(
    escrowAccount: aEscrow,
    depositorAccount: platform.publicKey,
    senderAccount: aSender,
    senderTokenAccount: ataSender,
    vaultTokenAccount: ataEscrow,
  );

  final message = Message.only(escrowIx);
  final latestBlockhash =
      await client.rpcClient.getLatestBlockhash(commitment: commitment);

  final compiled = message.compile(
    recentBlockhash: latestBlockhash.value.blockhash,
    feePayer: platform.publicKey,
  );

  final tx = SignedTx(
    compiledMessage: compiled,
    signatures: [
      await platform.sign(compiled.toByteArray()),
      Signature(List.filled(64, 0), publicKey: aSender),
    ],
  );

  return Product2(tx, latestBlockhash.context.slot);
}

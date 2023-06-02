import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/payments/escrow_account.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

Future<Product2<SignedTx, BigInt>> receivePaymentTx({
  required Ed25519HDPublicKey aEscrow,
  required Ed25519HDPublicKey aReceiver,
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

  final instructions = <Instruction>[];

  final ataEscrow = await findAssociatedTokenAddress(
    owner: aEscrow,
    mint: mint,
  );

  final ataReceiver = await findAssociatedTokenAddress(
    owner: aReceiver,
    mint: mint,
  );

  final shouldCreateAta = !await client.hasAssociatedTokenAccount(
    owner: aReceiver,
    mint: mint,
    commitment: commitment,
  );

  if (shouldCreateAta) {
    final iCreateATA = AssociatedTokenAccountInstruction.createAccount(
      funder: platform.publicKey,
      address: ataReceiver,
      owner: aReceiver,
      mint: mint,
    );

    instructions.add(iCreateATA);
  }

  final iTransfer = TokenInstruction.transfer(
    amount: escrow.amount,
    source: ataEscrow,
    destination: ataReceiver,
    owner: aEscrow,
  );

  instructions.add(iTransfer);

  final iCloseAccount = TokenInstruction.closeAccount(
    accountToClose: ataEscrow,
    destination: platform.publicKey,
    owner: aEscrow,
  );

  instructions.add(iCloseAccount);

  final message = Message(instructions: instructions);
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
      Signature(List.filled(64, 0), publicKey: aEscrow),
    ],
  );

  return Product2(tx, latestBlockhash.context.slot);
}

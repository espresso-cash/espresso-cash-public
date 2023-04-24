import 'package:dfunc/dfunc.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/escrow_payments/instructions.dart';
import 'package:solana/dto.dart' hide Instruction;
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

/// Creates a transaction that will:
///
/// - create ATA for the [aEscrow] account;
/// - send [amount] from [aSender] ATA to [aEscrow] ATA;
/// - send fee from [aSender] ATA to [platform] ATA;
///
/// Tx will be partially signed by the [platform]. Keep in mind that [aSender]
/// and [platform] should already have the corresponding ATAs for the [mint].
///
/// [commitment] is used for checking the ATA for [aSender] and for retrieving
/// the latest blockhash.
Future<Product2<SignedTx, BigInt>> createPaymentTx({
  required Ed25519HDPublicKey aSender,
  required Ed25519HDPublicKey aEscrow,
  required Ed25519HDPublicKey mint,
  required int amount,
  required Ed25519HDKeyPair platform,
  required SolanaClient client,
  required Commitment commitment,
}) async {
  final isNewEscrowAccount = await client.rpcClient
          .getAccountInfo(aEscrow.toBase58(), commitment: commitment)
          .value ==
      null;
  if (!isNewEscrowAccount) {
    throw Exception('Escrow account already exists');
  }

  final senderATAData = await client.getAssociatedTokenAccount(
    owner: aSender,
    mint: mint,
    commitment: commitment,
  );

  if (senderATAData == null) {
    throw Exception('No token account found for sender');
  }

  final ataSender = Ed25519HDPublicKey.fromBase58(senderATAData.pubkey);

  final instructions = <Instruction>[];

  final ataEscrow =
      await findAssociatedTokenAddress(owner: aEscrow, mint: mint);
  final iCreateATA = AssociatedTokenAccountInstruction.createAccount(
    funder: platform.publicKey,
    address: ataEscrow,
    owner: aEscrow,
    mint: mint,
  );

  instructions.add(iCreateATA);

  final ataPlatform = await findAssociatedTokenAddress(
    owner: platform.publicKey,
    mint: mint,
  );
  final iTransferFee = TokenInstruction.transfer(
    amount: escrowPaymentFee,
    source: ataSender,
    destination: ataPlatform,
    owner: aSender,
  );

  instructions.add(iTransferFee);

  final escrowIx = await EscrowInstruction.initEscrow(
    amount: amount,
    escrowAccount: aEscrow,
    senderAccount: aSender,
    depositorAccount: platform.publicKey,
    senderTokenAccount: ataSender,
    vaultTokenAccount: ataEscrow,
  );

  instructions.add(escrowIx);

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
      Signature(List.filled(64, 0), publicKey: aSender),
    ],
  );

  return Product2(tx, latestBlockhash.context.slot);
}

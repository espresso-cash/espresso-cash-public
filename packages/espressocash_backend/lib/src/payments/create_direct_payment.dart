import 'package:espressocash_backend/src/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'create_direct_payment.freezed.dart';

@freezed
class DirectPaymentResult with _$DirectPaymentResult {
  const factory DirectPaymentResult({
    required int fee,
    required SignedTx transaction,
  }) = _DirectPaymentResult;
}

/// Creates a transaction for a direct payment from [aSender] to [aReceiver] in
/// [mint].
///
/// It will:
///
/// - create ATA for the [aReceiver] account if needed;
/// - send [amount] from [aSender] ATA to [aReceiver] ATA;
/// - send fee from [aSender] ATA to [platform] ATA.
///
/// The amount of fee depends on whether the [aReceiver] has an ATA for the
/// [mint]. The resulting fee will be returned in [DirectPaymentResult].
Future<DirectPaymentResult> createDirectPayment({
  required Ed25519HDPublicKey aSender,
  required Ed25519HDPublicKey aReceiver,
  required Ed25519HDPublicKey? aReference,
  required Ed25519HDPublicKey mint,
  required int amount,
  required Ed25519HDKeyPair platform,
  required SolanaClient client,
  required Commitment commitment,
}) async {
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
      funder: platform.publicKey,
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
  if (aReference != null) {
    iTransfer.accounts
        .add(AccountMeta.readonly(pubKey: aReference, isSigner: false));
  }
  instructions.add(iTransfer);

  final fee =
      shouldCreateAta ? directPaymentWithAccountCreationFee : directPaymentFee;

  final ataPlatform = await findAssociatedTokenAddress(
    owner: platform.publicKey,
    mint: mint,
  );
  final iTransferFee = TokenInstruction.transfer(
    amount: fee,
    source: ataSender,
    destination: ataPlatform,
    owner: aSender,
  );
  instructions.add(iTransferFee);

  final message = Message(instructions: instructions);
  final recentBlockhash =
      await client.rpcClient.getLatestBlockhash(commitment: commitment);

  final compiled = message.compile(
    recentBlockhash: recentBlockhash.blockhash,
    feePayer: platform.publicKey,
  );

  final tx = SignedTx(
    compiledMessage: compiled,
    signatures: [
      await platform.sign(compiled.toByteArray()),
      Signature(List.filled(64, 0), publicKey: aSender),
    ],
  );

  return DirectPaymentResult(fee: fee, transaction: tx);
}

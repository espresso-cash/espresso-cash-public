import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../utils/transactions.dart';
import '../priority_fees/services/add_priority_fees.dart';
import '../tokens/token.dart';
import 'escrow_account.dart';
import 'instructions.dart';

@injectable
class CreateCanceledEscrow {
  const CreateCanceledEscrow(
    this._client,
    this._addPriorityFees,
    this._ecClient,
  );

  final SolanaClient _client;
  final AddPriorityFees _addPriorityFees;
  final EspressoCashClient _ecClient;

  Future<SignedTx> call({
    required Ed25519HDPublicKey escrowAccount,
    required Ed25519HDPublicKey senderAccount,
    required Commitment commitment,
  }) async {
    final mint = Token.usdc.publicKey;

    final nonceData = await _ecClient.getFreeNonce();
    final platformAccount = Ed25519HDPublicKey.fromBase58(nonceData.authority);

    await validateEscrow(
      address: escrowAccount,
      mint: mint,
      client: _client,
      commitment: commitment,
    );

    final ataSender = await findAssociatedTokenAddress(
      owner: senderAccount,
      mint: mint,
    );

    final ataEscrow = await findAssociatedTokenAddress(
      owner: escrowAccount,
      mint: mint,
    );

    final escrowIx = await EscrowInstruction.cancelEscrow(
      escrowAccount: escrowAccount,
      depositorAccount: platformAccount,
      senderAccount: senderAccount,
      senderTokenAccount: ataSender,
      vaultTokenAccount: ataEscrow,
    );

    final message = Message(
      instructions: [
        SystemInstruction.advanceNonceAccount(
          nonce: Ed25519HDPublicKey.fromBase58(nonceData.nonceAccount),
          nonceAuthority: platformAccount,
        ),
        escrowIx,
      ],
    );

    final compiled = message.compile(
      recentBlockhash: nonceData.nonce,
      feePayer: platformAccount,
    );

    final priorityFees = await _ecClient.getDurableFees();

    return await SignedTx(
      compiledMessage: compiled,
      signatures: [
        platformAccount.emptySignature(),
        senderAccount.emptySignature(),
      ],
    ).let(
      (tx) => _addPriorityFees(
        tx: tx,
        commitment: commitment,
        maxPriorityFee: priorityFees.cancelLink,
        platform: platformAccount,
      ),
    );
  }
}

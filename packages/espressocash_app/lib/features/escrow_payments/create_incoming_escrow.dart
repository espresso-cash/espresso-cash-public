import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../utils/transactions.dart';
import '../accounts/models/ec_wallet.dart';
import '../priority_fees/services/add_priority_fees.dart';
import '../tokens/token.dart';
import '../transactions/services/resign_tx.dart';
import 'escrow_account.dart';
import 'instructions.dart';

@injectable
class CreateIncomingEscrow {
  const CreateIncomingEscrow(
    this._client,
    this._addPriorityFees,
    this._ecClient,
  );

  final SolanaClient _client;
  final AddPriorityFees _addPriorityFees;
  final EspressoCashClient _ecClient;

  Future<SignedTx> call({
    required Ed25519HDKeyPair escrowAccount,
    required Ed25519HDPublicKey receiverAccount,
    required Commitment commitment,
  }) async {
    final mint = Token.usdc.publicKey;

    await validateEscrow(
      address: escrowAccount.publicKey,
      mint: mint,
      client: _client,
      commitment: commitment,
    );

    final nonceData = await _ecClient.getFreeNonce();
    final platformAccount = Ed25519HDPublicKey.fromBase58(nonceData.authority);

    final instructions = <Instruction>[];

    final ataEscrow = await findAssociatedTokenAddress(
      owner: escrowAccount.publicKey,
      mint: mint,
    );

    final ataReceiver = await findAssociatedTokenAddress(
      owner: receiverAccount,
      mint: mint,
    );

    final shouldCreateAta = !await _client.hasAssociatedTokenAccount(
      owner: receiverAccount,
      mint: mint,
      commitment: commitment,
    );

    if (shouldCreateAta) {
      final iCreateATA = AssociatedTokenAccountInstruction.createAccount(
        funder: platformAccount,
        address: ataReceiver,
        owner: receiverAccount,
        mint: mint,
      );

      instructions.add(iCreateATA);
    }

    final escrowIx = await EscrowInstruction.completeEscrow(
      escrowAccount: escrowAccount.publicKey,
      receiverTokenAccount: ataReceiver,
      depositorAccount: platformAccount,
      vaultTokenAccount: ataEscrow,
    );

    instructions.add(escrowIx);

    final int fee;
    if (shouldCreateAta) {
      final transactionFees = await _ecClient.getFees();
      fee = transactionFees.escrowPaymentAtaFee;
      final ataPlatform = await findAssociatedTokenAddress(
        owner: platformAccount,
        mint: mint,
      );
      final iTransferFee = TokenInstruction.transfer(
        amount: fee,
        source: ataReceiver,
        destination: ataPlatform,
        owner: receiverAccount,
      );
      instructions.add(iTransferFee);
    } else {
      fee = 0;
    }

    final message = Message(
      instructions: [
        SystemInstruction.advanceNonceAccount(
          nonce: Ed25519HDPublicKey.fromBase58(nonceData.nonceAccount),
          nonceAuthority: platformAccount,
        ),
        ...instructions,
      ],
    );

    final compiled = message.compile(
      recentBlockhash: nonceData.nonce,
      feePayer: platformAccount,
    );

    final priorityFees = await _ecClient.getDurableFees();

    return SignedTx(
      compiledMessage: compiled,
      signatures: [
        platformAccount.emptySignature(),
        escrowAccount.publicKey.emptySignature(),
        if (shouldCreateAta) receiverAccount.emptySignature(),
      ],
    )
        .let(
          (tx) => _addPriorityFees(
            tx: tx,
            commitment: commitment,
            maxPriorityFee: priorityFees.outgoingLink,
            platform: platformAccount,
          ),
        )
        .then((value) => value.resign(LocalWallet(escrowAccount)));
  }
}

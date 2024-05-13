import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../config.dart';
import '../priority_fees/services/add_priority_fees.dart';
import '../tokens/token.dart';
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

  Future<(SignedTx, BigInt)> call({
    required Ed25519HDPublicKey escrowAccount,
    required Ed25519HDPublicKey receiverAccount,
    required Commitment commitment,
  }) async {
    final mint = Token.usdc.publicKey;

    final nonceData = await _ecClient.getFreeNonce();
    final platformAccount = Ed25519HDPublicKey.fromBase58(nonceData.authority);

    final escrow = await tryFetchEscrow(
      address: escrowAccount,
      platform: platformAccount,
      mint: mint,
      client: _client,
      commitment: commitment,
    );

    if (escrow == null) {
      throw const EspressoCashException(
        error: EspressoCashError.invalidEscrowAccount,
      );
    }

    final instructions = <Instruction>[];

    final ataEscrow = await findAssociatedTokenAddress(
      owner: escrowAccount,
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
      escrowAccount: escrowAccount,
      receiverTokenAccount: ataReceiver,
      depositorAccount: platformAccount,
      vaultTokenAccount: ataEscrow,
    );

    instructions.add(escrowIx);

    final int fee;
    if (shouldCreateAta) {
      fee = escrowPaymentAccountCreationFee;
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

    final message = Message(instructions: instructions);
    final latestBlockhash =
        await _client.rpcClient.getLatestBlockhash(commitment: commitment);

    final compiled = message.compile(
      recentBlockhash: latestBlockhash.value.blockhash,
      feePayer: platformAccount,
    );

    final tx = await SignedTx(
      compiledMessage: compiled,
      signatures: [
        Signature(List.filled(64, 0), publicKey: platformAccount),
        Signature(List.filled(64, 0), publicKey: escrowAccount),
        if (shouldCreateAta)
          Signature(List.filled(64, 0), publicKey: receiverAccount),
      ],
    ).let(
      (tx) => _addPriorityFees(
        tx: tx,
        commitment: commitment,
        maxTxCostUsdc: _maxTxCostUsdc,
        platform: platformAccount,
      ),
    );

    return (tx, latestBlockhash.context.slot);
  }
}

const _maxTxCostUsdc = 9000;

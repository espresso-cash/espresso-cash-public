import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

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

  Future<(SignedTx, BigInt)> call({
    required Ed25519HDPublicKey escrowAccount,
    required Ed25519HDPublicKey senderAccount,
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

    final message = Message.only(escrowIx);
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
        Signature(List.filled(64, 0), publicKey: senderAccount),
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

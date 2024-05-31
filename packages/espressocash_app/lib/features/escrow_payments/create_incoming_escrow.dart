import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../config.dart';
import '../tokens/token.dart';
import 'escrow_account.dart';
import 'instructions.dart';

@injectable
class CreateIncomingEscrow {
  const CreateIncomingEscrow(
    this._client,
    this._ecClient,
  );

  final SolanaClient _client;
  final EspressoCashClient _ecClient;

  Future<SignedTx> call({
    required Ed25519HDPublicKey escrowAccount,
    required Ed25519HDPublicKey receiverAccount,
    required Commitment commitment,
  }) async {
    final mint = Token.usdc.publicKey;

    await validateEscrow(
      address: escrowAccount,
      mint: mint,
      client: _client,
      commitment: commitment,
    );

    final nonceData = await _ecClient.getFreeNonce();
    final platformAccount = Ed25519HDPublicKey.fromBase58(nonceData.authority);

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

    return SignedTx(
      compiledMessage: compiled,
      signatures: [
        Signature(List.filled(64, 0), publicKey: platformAccount),
        Signature(List.filled(64, 0), publicKey: escrowAccount),
        if (shouldCreateAta)
          Signature(List.filled(64, 0), publicKey: receiverAccount),
      ],
    );
  }
}

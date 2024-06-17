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
import 'instructions.dart';

typedef OutgoingEscrowData = ({SignedTx tx, Ed25519HDKeyPair escrow});

@injectable
class CreateOutgoingEscrow {
  const CreateOutgoingEscrow(
    this._client,
    this._addPriorityFees,
    this._ecClient,
  );

  final SolanaClient _client;
  final AddPriorityFees _addPriorityFees;
  final EspressoCashClient _ecClient;

  Future<OutgoingEscrowData> call({
    required Ed25519HDPublicKey senderAccount,
    required int amount,
    required Commitment commitment,
  }) async {
    final mint = Token.usdc.publicKey;

    final nonceData = await _ecClient.getFreeNonce();
    final platformAccount = Ed25519HDPublicKey.fromBase58(nonceData.authority);

    final escrowAccount = await Ed25519HDKeyPair.random();

    final senderATAData = await _client.getAssociatedTokenAccount(
      owner: senderAccount,
      mint: mint,
      commitment: commitment,
    );

    if (senderATAData == null) {
      throw Exception('No token account.');
    }

    final ataSender = Ed25519HDPublicKey.fromBase58(senderATAData.pubkey);

    final instructions = <Instruction>[];

    final ataEscrow = await findAssociatedTokenAddress(
      owner: escrowAccount.publicKey,
      mint: mint,
    );
    final iCreateATA = AssociatedTokenAccountInstruction.createAccount(
      funder: platformAccount,
      address: ataEscrow,
      owner: escrowAccount.publicKey,
      mint: mint,
    );

    instructions.add(iCreateATA);

    final transactionFees = await _ecClient.getFees();

    final ataPlatform = await findAssociatedTokenAddress(
      owner: platformAccount,
      mint: mint,
    );
    final iTransferFee = TokenInstruction.transfer(
      amount: transactionFees.escrowPayment,
      source: ataSender,
      destination: ataPlatform,
      owner: senderAccount,
    );

    instructions.add(iTransferFee);

    final escrowIx = await EscrowInstruction.initEscrow(
      amount: amount,
      escrowAccount: escrowAccount.publicKey,
      senderAccount: senderAccount,
      depositorAccount: platformAccount,
      senderTokenAccount: ataSender,
      vaultTokenAccount: ataEscrow,
    );

    instructions.add(escrowIx);

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
        senderAccount.emptySignature(),
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
        .then((value) => value.resign(LocalWallet(escrowAccount)))
        .then((tx) => (tx: tx, escrow: escrowAccount));
  }
}

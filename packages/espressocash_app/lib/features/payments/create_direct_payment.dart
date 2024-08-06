import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../utils/transactions.dart';
import '../priority_fees/services/add_priority_fees.dart';
import '../tokens/token.dart';

part 'create_direct_payment.freezed.dart';

@freezed
class DirectPaymentResult with _$DirectPaymentResult {
  const factory DirectPaymentResult({
    required int fee,
    required SignedTx transaction,
  }) = _DirectPaymentResult;
}

@injectable
class CreateDirectPayment {
  const CreateDirectPayment(
    this._client,
    this._addPriorityFees,
    this._ecClient,
  );

  final SolanaClient _client;
  final AddPriorityFees _addPriorityFees;
  final EspressoCashClient _ecClient;

  Future<DirectPaymentResult> call({
    required Ed25519HDPublicKey aSender,
    required Ed25519HDPublicKey aReceiver,
    required Ed25519HDPublicKey? aReference,
    required int amount,
    required Commitment commitment,
  }) async {
    final mint = Token.usdc.publicKey;

    final nonceData = await _ecClient.getFreeNonce();
    final platformAccount = Ed25519HDPublicKey.fromBase58(nonceData.authority);

    final shouldCreateAta = !await _client.hasAssociatedTokenAccount(
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
        funder: platformAccount,
        address: ataReceiver,
        owner: aReceiver,
        mint: mint,
      );
      instructions.add(iCreateATA);
    }

    final transactionFees = await _ecClient.getFees();

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

    final fee = shouldCreateAta
        ? transactionFees.directPayment.ataDoesNotExist
        : transactionFees.directPayment.ataExists;

    final ataPlatform = await findAssociatedTokenAddress(
      owner: platformAccount,
      mint: mint,
    );
    final iTransferFee = TokenInstruction.transfer(
      amount: fee,
      source: ataSender,
      destination: ataPlatform,
      owner: aSender,
    );
    instructions.add(iTransferFee);

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

    final tx = await SignedTx(
      compiledMessage: compiled,
      signatures: [
        platformAccount.emptySignature(),
        aSender.emptySignature(),
      ],
    ).let(
      (tx) => _addPriorityFees(
        tx: tx,
        commitment: commitment,
        maxPriorityFee: priorityFees.outgoingLink,
        platform: platformAccount,
      ),
    );

    return DirectPaymentResult(
      fee: fee,
      transaction: tx,
    );
  }
}

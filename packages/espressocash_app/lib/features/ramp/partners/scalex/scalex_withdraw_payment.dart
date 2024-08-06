import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../utils/transactions.dart';
import '../../../priority_fees/services/add_priority_fees.dart';
import '../../../tokens/token.dart';

part 'scalex_withdraw_payment.freezed.dart';

@freezed
class WithdrawPaymentResult with _$WithdrawPaymentResult {
  const factory WithdrawPaymentResult({
    required int fee,
    required SignedTx transaction,
  }) = _WithdrawPaymentResult;
}

@injectable
class ScalexWithdrawPayment {
  const ScalexWithdrawPayment(
    this._client,
    this._addPriorityFees,
    this._ecClient,
  );

  final SolanaClient _client;
  final AddPriorityFees _addPriorityFees;
  final EspressoCashClient _ecClient;

  Future<WithdrawPaymentResult> call({
    required Ed25519HDPublicKey aSender,
    required Ed25519HDPublicKey aReceiver,
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

    instructions.add(iTransfer);

    final txFee = shouldCreateAta
        ? transactionFees.directPayment.ataDoesNotExist
        : transactionFees.directPayment.ataExists;

    final ataPlatform = await findAssociatedTokenAddress(
      owner: platformAccount,
      mint: mint,
    );

    final espressoFee = await _ecClient.fetchScalexFeesAndRate();

    final scalexOffRampFeeFraction = espressoFee.espressoFeePercentage;

    final percentageFeeAmount = (amount * scalexOffRampFeeFraction).ceil();
    final totalFee = max(percentageFeeAmount, txFee);
    final iTransferPercentageFee = TokenInstruction.transfer(
      amount: totalFee,
      source: ataSender,
      destination: ataPlatform,
      owner: aSender,
    );
    instructions.add(iTransferPercentageFee);

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

    return WithdrawPaymentResult(
      fee: totalFee,
      transaction: tx,
    );
  }
}

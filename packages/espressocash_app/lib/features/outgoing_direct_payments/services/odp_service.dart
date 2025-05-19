import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../analytics/analytics_manager.dart';
import '../../balances/services/refresh_balance.dart';
import '../../currency/models/amount.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_direct_payment.dart';

@Singleton(scope: authScope)
class ODPService {
  ODPService(
    this._client,
    this._repository,
    this._txSender,
    this._analyticsManager,
    this._refreshBalance,
    this._solanaClient,
  );

  final EspressoCashClient _client;
  final ODPRepository _repository;
  final TxSender _txSender;
  final AnalyticsManager _analyticsManager;
  final RefreshBalance _refreshBalance;
  final SolanaClient _solanaClient;

  final Map<String, StreamSubscription<void>> _subscriptions = {};

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final nonCompletedPayments = await _repository.getNonCompletedPaymentIds();

    for (final payment in nonCompletedPayments) {
      _subscribe(payment);
    }
  }

  Future<OutgoingDirectPayment> create({
    required ECWallet account,
    required CryptoAmount amount,
    required Ed25519HDPublicKey receiver,
    required Ed25519HDPublicKey? reference,
  }) async {
    final id = const Uuid().v4();

    final status =
        amount.token.isSolana
            ? await _createSolTx(
              account: account,
              receiver: receiver,
              amount: amount,
              reference: reference,
            )
            : await _createTokenTx(
              account: account,
              receiver: receiver,
              amount: amount,
              reference: reference,
            );

    final payment = OutgoingDirectPayment(
      id: id,
      receiver: receiver,
      reference: reference,
      amount: amount,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);
    _subscribe(id);

    return payment;
  }

  Future<void> cancel(String paymentId) async {
    final payment = await _repository.load(paymentId);
    if (payment == null || !payment.isRetriable) return;

    await _repository.delete(paymentId);
  }

  Future<ODPStatus> _createSolTx({
    required CryptoAmount amount,
    required ECWallet account,
    required Ed25519HDPublicKey receiver,
    required Ed25519HDPublicKey? reference,
  }) async {
    try {
      final latestBlockhash = await _solanaClient.rpcClient.getLatestBlockhash(
        commitment: Commitment.confirmed,
      );

      final transferInstruction = SystemInstruction.transfer(
        fundingAccount: account.publicKey,
        recipientAccount: receiver,
        lamports: amount.value,
      );

      final message = Message(
        instructions: [
          transferInstruction,
          if (reference != null)
            MemoInstruction(memo: reference.toBase58(), signers: [account.publicKey]),
        ],
      );

      final compiled = message.compile(
        recentBlockhash: latestBlockhash.value.blockhash,
        feePayer: account.publicKey,
      );

      final signedTx = SignedTx(
        compiledMessage: compiled,
        signatures: [Signature(List.filled(64, 0), publicKey: account.publicKey)],
      );

      final tx = await signedTx.resign(account);

      return ODPStatus.txCreated(tx, slot: BigInt.from(latestBlockhash.context.slot.toInt()));
    } on Exception {
      return const ODPStatus.txFailure(reason: TxFailureReason.creatingFailure);
    }
  }

  Future<ODPStatus> _createTokenTx({
    required CryptoAmount amount,
    required ECWallet account,
    required Ed25519HDPublicKey receiver,
    required Ed25519HDPublicKey? reference,
  }) async {
    try {
      final dto = CreateDirectPaymentRequestDto(
        senderAccount: account.address,
        receiverAccount: receiver.toBase58(),
        referenceAccount: reference?.toBase58(),
        amount: amount.value,
        mintAddress: amount.token.address,
      );
      final response = await _client.createDirectPayment(dto);
      final tx = await response
          .let((it) => it.transaction)
          .let(SignedTx.decode)
          .let((it) => it.resign(account));

      return ODPStatus.txCreated(tx, slot: response.slot);
    } on Exception {
      return const ODPStatus.txFailure(reason: TxFailureReason.creatingFailure);
    }
  }

  void _subscribe(String paymentId) {
    _subscriptions[paymentId] = _repository
        .watch(paymentId)
        .asyncExpand<OutgoingDirectPayment?>((payment) {
          switch (payment.status) {
            case ODPStatusTxCreated():
              return _send(payment).asStream();
            case ODPStatusTxSent():
              return _wait(payment).asStream();
            case ODPStatusSuccess():
            case ODPStatusTxFailure():
              _subscriptions.remove(paymentId)?.cancel();

              return null;
          }
        })
        .listen((payment) => payment?.let(_repository.save));
  }

  Future<OutgoingDirectPayment> _send(OutgoingDirectPayment payment) async {
    final status = payment.status;
    if (status is! ODPStatusTxCreated) {
      return payment;
    }

    final tx = await _txSender.send(status.tx, minContextSlot: status.slot);

    final ODPStatus? newStatus = tx.map(
      sent: (_) => ODPStatus.txSent(status.tx, slot: status.slot),
      invalidBlockhash:
          (_) => const ODPStatus.txFailure(reason: TxFailureReason.invalidBlockhashSending),
      failure: (it) => ODPStatus.txFailure(reason: it.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? payment : payment.copyWith(status: newStatus);
  }

  Future<OutgoingDirectPayment> _wait(OutgoingDirectPayment payment) async {
    final status = payment.status;
    if (status is! ODPStatusTxSent) {
      return payment;
    }

    final tx = await _txSender.wait(
      status.tx,
      minContextSlot: status.slot,
      txType: 'OutgoingDirectPayment',
    );

    final ODPStatus? newStatus = tx.map(
      success: (_) => ODPStatus.success(txId: status.tx.id),
      failure: (tx) => ODPStatus.txFailure(reason: tx.reason),
      networkError: (_) => null,
    );

    if (newStatus is ODPStatusSuccess) {
      _analyticsManager.directPaymentSent(
        symbol: payment.amount.token.symbol,
        amount: payment.amount.decimal,
      );

      _refreshBalance();
    }

    return newStatus == null ? payment : payment.copyWith(status: newStatus);
  }
}

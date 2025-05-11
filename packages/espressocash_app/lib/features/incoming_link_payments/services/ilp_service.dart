import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../analytics/analytics_manager.dart';
import '../../balances/services/refresh_balance.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../escrow/models/escrow_private_key.dart';
import '../../tokens/token.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/ilp_repository.dart';
import '../models/incoming_link_payment.dart';

@Singleton(scope: authScope)
class ILPService implements Disposable {
  ILPService(
    this._repository,
    this._ecClient,
    this._refreshBalance,
    this._txSender,
    this._solanaClient,
    this._wallet,
    this._analytics,
  );

  final ILPRepository _repository;
  final EspressoCashClient _ecClient;
  final RefreshBalance _refreshBalance;
  final TxSender _txSender;
  final SolanaClient _solanaClient;
  final ECWallet _wallet;
  final AnalyticsManager _analytics;

  final Map<String, StreamSubscription<void>> _subscriptions = {};

  void _subscribe(String id) {
    _subscriptions[id] = _repository
        .watch(id)
        .whereNotNull()
        .asyncExpand<IncomingLinkPayment?>((payment) {
          switch (payment.status) {
            case ILPStatusTxCreated():
              return _send(payment).asStream();
            case ILPStatusTxSent():
              return _wait(payment).asStream();
            case ILPStatusSuccess():
            case ILPStatusTxFailure():
              _subscriptions.remove(id)?.cancel();

              return null;
          }
        })
        .listen((payment) => payment?.let(_repository.save));
  }

  Future<IncomingLinkPayment> create({
    required ECWallet account,
    required Ed25519HDKeyPair escrow,
  }) async {
    final status = await _createTx(escrow: escrow, account: account);

    final id = const Uuid().v4();

    final payment = IncomingLinkPayment(
      id: id,
      created: DateTime.now(),
      escrow: await escrow.let(EscrowPrivateKey.fromKeyPair),
      status: status,
    );

    await _repository.save(payment);
    _subscribe(id);

    return payment;
  }

  Future<ILPStatus> _createTx({required ECWallet account, required Ed25519HDKeyPair escrow}) async {
    try {
      final dto = ReceivePaymentRequestDto(
        receiverAccount: account.address,
        escrowAccount: escrow.address,
      );

      final response = await _ecClient.receivePaymentEc(dto);

      final tx = await response.transaction
          .let(SignedTx.decode)
          .let((it) => it.resign(LocalWallet(escrow)))
          .letAsync((it) => it.resign(account));

      return ILPStatus.txCreated(tx, slot: response.slot);
    } on Exception {
      return const ILPStatus.txFailure(reason: TxFailureReason.creatingFailure);
    }
  }

  Future<IncomingLinkPayment?> _send(IncomingLinkPayment payment) async {
    final status = payment.status;
    if (status is! ILPStatusTxCreated) {
      return payment;
    }

    try {
      final fee = await _ecClient.getIncomingEscrowPaymentQuote().then(
        (it) => it.fee == 0 ? null : CryptoAmount(value: it.fee, cryptoCurrency: Currency.usdc),
      );

      final tx = await _txSender.send(status.tx, minContextSlot: status.slot);

      final ILPStatus? newStatus = tx.map(
        sent: (_) => ILPStatus.txSent(status.tx, slot: status.slot, fee: fee),
        invalidBlockhash:
            (_) => const ILPStatus.txFailure(reason: TxFailureReason.invalidBlockhashSending),
        failure: (it) => ILPStatus.txFailure(reason: it.reason),
        networkError: (_) {
          Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));
        },
      );

      return newStatus == null ? null : payment.copyWith(status: newStatus);
    } on Exception {
      return payment.copyWith(
        status: const ILPStatus.txFailure(reason: TxFailureReason.creatingFailure),
      );
    }
  }

  Future<IncomingLinkPayment?> _wait(IncomingLinkPayment payment) async {
    final status = payment.status;

    if (status is! ILPStatusTxSent) {
      return payment;
    }

    final tx = await _txSender.wait(
      status.tx,
      minContextSlot: status.slot,
      txType: 'IncomingLinkPayment',
    );

    final newStatus = await tx.map(
      success: (_) async {
        try {
          final receiveAmount = await _getUsdcAmount(status.tx.id);

          _refreshBalance();
          _analytics.singleLinkReceived(amount: receiveAmount?.decimal);

          return ILPStatus.success(tx: status.tx, receiveAmount: receiveAmount, fee: status.fee);
        } on Object {
          return null;
        }
      },
      failure:
          (_) => Future.value(const ILPStatus.txFailure(reason: TxFailureReason.escrowFailure)),
      networkError: (_) async {
        await Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));
      },
    );

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }

  Future<CryptoAmount?> _getUsdcAmount(String signature) async {
    try {
      final details = await _solanaClient.rpcClient.getTransaction(
        signature,
        encoding: Encoding.base64,
        commitment: Commitment.confirmed,
      );

      if (details == null) return null;

      final usdcTokenAddress = await findAssociatedTokenAddress(
        owner: _wallet.publicKey,
        mint: Ed25519HDPublicKey.fromBase58(Token.usdc.address),
      );

      // ignore: avoid-type-casts, controlled type
      final rawTx = details.transaction as RawTransaction;
      final tx = SignedTx.fromBytes(rawTx.data);

      final accountIndex = tx.compiledMessage.accountKeys.indexWhere((e) => e == usdcTokenAddress);

      final postTokenBalance =
          details.meta?.postTokenBalances
              .where((e) => e.mint == Token.usdc.address)
              .where((e) => e.accountIndex == accountIndex)
              .firstOrNull;

      if (postTokenBalance == null) return null;

      final preTokenBalance =
          details.meta?.preTokenBalances
              .where((e) => e.mint == Token.usdc.address)
              .where((e) => e.accountIndex == accountIndex)
              .firstOrNull;

      final preAmount = preTokenBalance?.uiTokenAmount.amount ?? '0';
      final postAmount = postTokenBalance.uiTokenAmount.amount;

      final rawAmount = int.parse(postAmount) - int.parse(preAmount);

      if (rawAmount <= 0) return null;

      return CryptoAmount(value: rawAmount, cryptoCurrency: Currency.usdc);
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
  }
}

import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/errors.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../analytics/analytics_manager.dart';
import '../../balances/services/refresh_balance.dart';
import '../../currency/models/amount.dart';
import '../../escrow/models/escrow_private_key.dart';
import '../../link_payments/models/link_payment.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';

@Singleton(scope: authScope)
class OLPService implements Disposable {
  OLPService(
    this._repository,
    this._ecClient,
    this._txSender,
    this._analyticsManager,
    this._refreshBalance,
  );

  final OLPRepository _repository;
  final EspressoCashClient _ecClient;
  final TxSender _txSender;
  final AnalyticsManager _analyticsManager;
  final RefreshBalance _refreshBalance;

  final Map<String, StreamSubscription<void>> _subscriptions = {};

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final nonCompletedPayments = await _repository.getNonCompletedPaymentIds();

    for (final payment in nonCompletedPayments) {
      _subscribe(payment);
    }
  }

  void _subscribe(String id) {
    _subscriptions[id] = _repository
        .watch(id)
        .asyncExpand<OutgoingLinkPayment?>((payment) {
          switch (payment.status) {
            case OLPStatusTxCreated():
              return _sendOutgoing(payment).asStream();
            case OLPStatusTxSent():
              return _wait(payment).asStream();

            case OLPStatusLinkReady():
            case OLPStatusWithdrawn():
            case OLPStatusCanceled():
              _subscriptions.remove(id)?.cancel();

              return null;

            case OLPStatusCancelTxCreated():
              return _sendCanceled(payment).asStream();
            case OLPStatusCancelTxSent():
              return _processCanceled(payment).asStream();

            case OLPStatusTxFailure():
            case OLPStatusCancelTxFailure():
            case OLPStatusTxConfirmed():
              return null;
          }
        })
        .where((payment) => payment != null)
        .cast<OutgoingLinkPayment>()
        .listen((payment) => payment.let(_repository.save));
  }

  Future<OutgoingLinkPayment> create({
    required CryptoAmount amount,
    required ECWallet account,
  }) async {
    final status = await _createTx(amount: amount, account: account);

    final id = const Uuid().v4();

    final payment = OutgoingLinkPayment(
      id: id,
      amount: amount,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);
    _subscribe(id);

    return payment;
  }

  Future<OutgoingLinkPayment> cancel(
    OutgoingLinkPayment payment, {
    required ECWallet account,
  }) async {
    final status = payment.status;

    final OLPStatus newStatus;
    if (status is OLPStatusTxFailure) {
      newStatus = OLPStatus.canceled(txId: null, timestamp: DateTime.now());
    } else {
      final escrow = status.mapOrNull(
        linkReady: (it) => it.escrow,
        cancelTxFailure: (it) => it.escrow,
      );

      if (escrow == null) {
        return payment;
      }

      newStatus = await _createCancelTx(
        escrow: await Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: escrow.bytes),
        account: account,
      );
    }

    final newPayment = payment.copyWith(status: newStatus);

    await _repository.save(newPayment);
    _subscribe(payment.id);

    return newPayment;
  }

  Future<OLPStatus> _createTx({required CryptoAmount amount, required ECWallet account}) async {
    try {
      final escrowAccount = await Ed25519HDKeyPair.random();
      final privateKey = await EscrowPrivateKey.fromKeyPair(escrowAccount);

      final dto = CreatePaymentRequestDto(
        senderAccount: account.address,
        escrowAccount: escrowAccount.address,
        amount: amount.value,
      );

      final response = await _ecClient.createPaymentEc(dto);

      final tx = await response.transaction
          .let(SignedTx.decode)
          .let((it) => it.resign(account))
          .letAsync((it) => it.resign(LocalWallet(escrowAccount)));

      return OLPStatus.txCreated(tx, escrow: privateKey, slot: response.slot);
    } on Exception {
      return const OLPStatus.txFailure(reason: TxFailureReason.creatingFailure);
    }
  }

  Future<OLPStatus> _createCancelTx({
    required Ed25519HDKeyPair escrow,
    required ECWallet account,
  }) async {
    final privateKey = await EscrowPrivateKey.fromKeyPair(escrow);

    try {
      final dto = CancelPaymentRequestDto(
        senderAccount: account.address,
        escrowAccount: escrow.address,
      );

      final response = await _ecClient.cancelPaymentEc(dto);
      final transaction = response.transaction;
      final slot = response.slot;
      final tx = await transaction.let(SignedTx.decode).let((it) => it.resign(account));

      return OLPStatus.cancelTxCreated(tx, escrow: privateKey, slot: slot);
    } on Exception {
      return OLPStatus.cancelTxFailure(escrow: privateKey, reason: TxFailureReason.creatingFailure);
    }
  }

  Future<OutgoingLinkPayment?> _sendOutgoing(OutgoingLinkPayment payment) async {
    final status = payment.status;
    if (status is! OLPStatusTxCreated) {
      return payment;
    }

    try {
      final tx = await _txSender.send(status.tx, minContextSlot: status.slot);

      final OLPStatus? newStatus = tx.map(
        sent: (_) => OLPStatus.txSent(status.tx, escrow: status.escrow, slot: status.slot),
        invalidBlockhash:
            (_) => const OLPStatus.txFailure(reason: TxFailureReason.invalidBlockhashSending),
        failure: (it) => OLPStatus.txFailure(reason: it.reason),
        networkError: (_) => const OLPStatus.txFailure(reason: TxFailureReason.unknown),
      );

      if (newStatus is OLPStatusTxSent) {
        _analyticsManager.singleLinkCreated(amount: payment.amount.decimal);
      }

      return newStatus == null ? payment : payment.copyWith(status: newStatus);
    } on Exception catch (error) {
      TxFailureReason reason = TxFailureReason.creatingFailure;

      final ecError = error.toEspressoCashError();

      if (ecError == EspressoCashError.insufficientFunds) {
        reason = TxFailureReason.insufficientFunds;
      }

      return payment.copyWith(status: OLPStatus.txFailure(reason: reason));
    }
  }

  Future<OutgoingLinkPayment?> _wait(OutgoingLinkPayment payment) async {
    final status = payment.status;
    if (status is! OLPStatusTxSent) {
      return payment;
    }

    final tx = await _txSender.wait(
      status.tx,
      minContextSlot: status.slot,
      txType: 'OutgoingLinkPayment',
    );

    final OLPStatus? newStatus = tx.map(
      success: (_) => null,
      failure: (it) => OLPStatus.txFailure(reason: it.reason),
      networkError: (_) {
        Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));

        return const OLPStatus.txFailure(reason: TxFailureReason.unknown);
      },
    );

    if (newStatus != null) {
      return payment.copyWith(status: newStatus);
    }

    final token = payment.amount.token;

    final privateKey = status.escrow.bytes.lock;
    final key = base58encode(privateKey.toList());

    final link = LinkPayment(key: key, token: token.publicKey).toShareableLink();

    _refreshBalance();

    return payment.copyWith(status: OLPStatus.linkReady(link: link, escrow: status.escrow));
  }

  Future<OutgoingLinkPayment?> _sendCanceled(OutgoingLinkPayment payment) async {
    final status = payment.status;
    if (status is! OLPStatusCancelTxCreated) {
      return payment;
    }

    try {
      final tx = await _txSender.send(status.tx, minContextSlot: status.slot);

      final OLPStatus? newStatus = tx.map(
        sent: (_) => OLPStatus.cancelTxSent(status.tx, escrow: status.escrow, slot: status.slot),
        invalidBlockhash:
            (_) => OLPStatus.cancelTxFailure(
              reason: TxFailureReason.invalidBlockhashSending,
              escrow: status.escrow,
            ),
        failure: (it) => OLPStatus.cancelTxFailure(reason: it.reason, escrow: status.escrow),
        networkError:
            (_) =>
                OLPStatus.cancelTxFailure(reason: TxFailureReason.unknown, escrow: status.escrow),
      );

      return newStatus == null ? payment : payment.copyWith(status: newStatus);
    } on Exception {
      return payment.copyWith(
        status: OLPStatus.cancelTxFailure(
          reason: TxFailureReason.creatingFailure,
          escrow: status.escrow,
        ),
      );
    }
  }

  Future<OutgoingLinkPayment?> _processCanceled(OutgoingLinkPayment payment) async {
    final status = payment.status;

    if (status is! OLPStatusCancelTxSent) {
      return payment;
    }

    final tx = await _txSender.wait(
      status.tx,
      minContextSlot: status.slot,
      txType: 'OutgoingLinkPaymentCancelation',
    );

    final OLPStatus? newStatus = tx.map(
      success: (_) => OLPStatus.canceled(txId: status.tx.id, timestamp: DateTime.now()),
      failure: (it) => OLPStatus.cancelTxFailure(reason: it.reason, escrow: status.escrow),
      networkError: (_) {
        Sentry.addBreadcrumb(Breadcrumb(message: 'Network error'));

        return OLPStatus.cancelTxFailure(reason: TxFailureReason.unknown, escrow: status.escrow);
      },
    );

    if (newStatus is OLPStatusCanceled) {
      _analyticsManager.singleLinkCanceled(amount: payment.amount.decimal);
      _refreshBalance();
    }

    return newStatus == null ? null : payment.copyWith(status: newStatus);
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
  }
}

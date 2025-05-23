import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../../data/db/db.dart';
import '../../../../../utils/errors.dart';
import '../../../../accounts/auth_scope.dart';
import '../../../../accounts/models/ec_wallet.dart';
import '../../../../analytics/analytics_manager.dart';
import '../../../../currency/models/amount.dart';
import '../../../../kyc_sharing/data/kyc_repository.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../../tokens/token.dart';
import '../../../services/extensions.dart';
import '../models/brij_order_status.dart';

@Singleton(scope: authScope)
class BrijOnRampOrderService implements Disposable {
  BrijOnRampOrderService(this._db, this._kycRepository, this._ecWallet, this._analytics);

  final MyDatabase _db;
  final KycRepository _kycRepository;
  final ECWallet _ecWallet;
  final AnalyticsManager _analytics;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  final Map<String, StreamSubscription<void>> _watchers = {};

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final query = _db.select(_db.onRampOrderRows)..where(
      (tbl) =>
          tbl.status.isNotInValues([OnRampOrderStatus.completed, OnRampOrderStatus.failure]) &
          tbl.partner.isInValues([RampPartner.brij]),
    );

    final orders = await query.get();

    for (final order in orders) {
      switch (order.partner) {
        case RampPartner.kado:
        case RampPartner.coinflow:
        case RampPartner.guardarian:
        case RampPartner.rampNetwork:
        case RampPartner.moneygram:
          // ignore: avoid-unnecessary-continue, needed here
          continue;
        case RampPartner.brij:
          _subscribe(order.id);
      }
    }
  }

  void _subscribe(String orderId) {
    _subscriptions[orderId] = (_db.select(_db.onRampOrderRows)
          ..where((tbl) => tbl.id.equals(orderId)))
        .watchSingleOrNull()
        .whereNotNull()
        .asyncExpand<OnRampOrderRowsCompanion?>((order) {
          if (order.shouldReportToSentry) {
            logMessage(message: 'BrijOnRampOrderStatusChange', data: order.toSentry());
          }

          switch (order.status) {
            case OnRampOrderStatus.waitingPartnerReview:
              _waitingPartnerReviewWatcher(order);

              return const Stream.empty();

            case OnRampOrderStatus.waitingForPartner:
              _waitingForPartnerWatcher(order);

              return const Stream.empty();

            case OnRampOrderStatus.pending:
            case OnRampOrderStatus.preProcessing:
            case OnRampOrderStatus.postProcessing:
            case OnRampOrderStatus.waitingForBridge:
            case OnRampOrderStatus.completed:
            case OnRampOrderStatus.failure:
            case OnRampOrderStatus.waitingForDeposit:
            case OnRampOrderStatus.depositExpired:
            case OnRampOrderStatus.rejected:
              return const Stream.empty();
          }
        })
        .whereNotNull()
        .listen(
          (event) =>
              (_db.update(_db.onRampOrderRows)
                ..where((tbl) => tbl.id.equals(orderId))).write(event),
        );
  }

  AsyncResult<String> create({
    required FiatAmount submittedAmount,
    required CryptoAmount receiveAmount,
    required RampPartner partner,
    required String country,
  }) => tryEitherAsync((_) async {
    final partnerAuthPk = partner.partnerPK ?? '';
    await _kycRepository.grantPartnerAccess(partnerAuthPk);

    final orderId = await _kycRepository.createOnRampOrder(
      cryptoAmount: receiveAmount.decimal.toDouble(),
      cryptoCurrency: receiveAmount.cryptoCurrency.token.symbol,
      fiatAmount: submittedAmount.decimal.toDouble(),
      fiatCurrency: submittedAmount.currency.symbol,
      partnerPK: partnerAuthPk,
      cryptoWalletAddress: _ecWallet.publicKey.toString(),
      walletPK: walletAuthPk,
    );

    final order = OnRampOrderRow(
      id: const Uuid().v4(),
      partnerOrderId: orderId,
      amount: submittedAmount.value,
      token: Token.usdc.address,
      humanStatus: '',
      machineStatus: '',
      isCompleted: false,
      created: DateTime.now(),
      txHash: '',
      partner: partner,
      receiveAmount: receiveAmount.value,
      status: OnRampOrderStatus.waitingPartnerReview,
      bankAccount: null,
      bankName: null,
      bankTransferAmount: submittedAmount.value,
      fiatSymbol: submittedAmount.currency.symbol,
      authToken: null,
      moreInfoUrl: null,
    );

    await _db.into(_db.onRampOrderRows).insertOnConflictUpdate(order);
    _subscribe(order.id);

    _analytics.rampInitiated(
      partnerName: partner.name,
      rampType: RampType.onRamp.name,
      amount: submittedAmount.value.toString(),
      countryCode: country,
      id: order.id,
    );

    return order.id;
  });

  // Either approve or reject
  void _waitingPartnerReviewWatcher(OnRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 10)).startWith(null).listen((
      _,
    ) async {
      final statement = _db.update(_db.onRampOrderRows)..where((tbl) => tbl.id.equals(id));

      final orderData = await _kycRepository.fetchOrder(order.partnerOrderId);
      final kycStatus = BrijOrderStatus.fromString(orderData.status);

      final status = switch (kycStatus) {
        BrijOrderStatus.completed => OnRampOrderStatus.completed,
        BrijOrderStatus.unknown || BrijOrderStatus.rejected => OnRampOrderStatus.rejected,
        BrijOrderStatus.failed => OnRampOrderStatus.failure,
        BrijOrderStatus.pending => OnRampOrderStatus.waitingPartnerReview,
        BrijOrderStatus.accepted => OnRampOrderStatus.waitingForDeposit,
      };

      if (status != order.status) {
        await statement.write(
          OnRampOrderRowsCompanion(
            status: Value.ofNullable(status),
            bankAccount: Value.ofNullable(orderData.bankAccount),
            bankName: Value.ofNullable(orderData.bankName),
            bankTransferExpiry: Value.ofNullable(DateTime.now().add(const Duration(minutes: 30))),
          ),
        );

        _removeWatcher(id);
      }
    });
  }

  // Either complete or fail
  void _waitingForPartnerWatcher(OnRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 10)).startWith(null).listen((
      _,
    ) async {
      final statement = _db.update(_db.onRampOrderRows)..where((tbl) => tbl.id.equals(id));

      final orderData = await _kycRepository.fetchOrder(order.partnerOrderId);
      final kycStatus = BrijOrderStatus.fromString(orderData.status);

      final status = switch (kycStatus) {
        BrijOrderStatus.completed => OnRampOrderStatus.completed,
        BrijOrderStatus.unknown || BrijOrderStatus.rejected => OnRampOrderStatus.rejected,
        BrijOrderStatus.failed => OnRampOrderStatus.failure,
        BrijOrderStatus.pending => OnRampOrderStatus.waitingPartnerReview,
        BrijOrderStatus.accepted => OnRampOrderStatus.waitingForDeposit,
      };

      if (status == OnRampOrderStatus.waitingForDeposit) return;

      if (status != order.status) {
        final isCompleted = status == OnRampOrderStatus.completed;
        await statement.write(
          OnRampOrderRowsCompanion(
            isCompleted: Value.ofNullable(isCompleted),
            status: Value.ofNullable(status),
            txHash: Value.ofNullable(orderData.transactionId),
          ),
        );

        _removeWatcher(id);
      }
    });
  }

  void _removeWatcher(String id) {
    _watchers.remove(id)?.cancel();
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
    _watchers.values.map((it) => it.cancel());
  }
}

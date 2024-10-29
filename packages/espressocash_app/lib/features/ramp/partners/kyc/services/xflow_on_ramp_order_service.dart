import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../../data/db/db.dart';
import '../../../../accounts/auth_scope.dart';
import '../../../../analytics/analytics_manager.dart';
import '../../../../currency/models/amount.dart';
import '../../../../kyc_sharing/data/kyc_repository.dart';
import '../../../../kyc_sharing/models/kyc_order_status.dart';
import '../../../../kyc_sharing/services/kyc_service.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../../tokens/token.dart';

@Singleton(scope: authScope)
class XFlowOnRampOrderService implements Disposable {
  XFlowOnRampOrderService(this._db, this._kycRepository, this._analytics);

  final MyDatabase _db;
  final KycRepository _kycRepository;
  final AnalyticsManager _analytics;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  final Map<String, StreamSubscription<void>> _watchers = {};

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final query = _db.select(_db.onRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.isNotInValues([
              OnRampOrderStatus.completed,
              OnRampOrderStatus.failure,
            ]) &
            tbl.partner.equalsValue(RampPartner.xflow),
      );

    final orders = await query.get();

    for (final order in orders) {
      if (order.partner != RampPartner.xflow) {
        continue;
      }

      _subscribe(order.id);
    }
  }

  void _subscribe(String orderId) {
    _subscriptions[orderId] = (_db.select(_db.onRampOrderRows)
          ..where((tbl) => tbl.id.equals(orderId)))
        .watchSingleOrNull()
        .whereNotNull()
        .asyncExpand<OnRampOrderRowsCompanion?>((order) {
          switch (order.status) {
            case OnRampOrderStatus.waitingPartnerReview:
              _waitingPartnerReviewWatcher(order);

              return const Stream.empty();

            case OnRampOrderStatus.waitingForPartner:
              _waitingForPartnerWatcher(order);

              return const Stream.empty();

            case OnRampOrderStatus.waitingUserVerification:
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
          (event) => (_db.update(_db.onRampOrderRows)
                ..where((tbl) => tbl.id.equals(orderId)))
              .write(event),
        );
  }

  AsyncResult<String> createPreOrder({
    required FiatAmount submittedAmount,
  }) =>
      tryEitherAsync((_) async {
        {
          final order = OnRampOrderRow(
            id: const Uuid().v4(),
            partnerOrderId: '',
            amount: submittedAmount.value,
            token: Token.usdc.address,
            humanStatus: '',
            machineStatus: '',
            isCompleted: false,
            created: DateTime.now(),
            txHash: '',
            partner: RampPartner.xflow,
            status: OnRampOrderStatus.waitingUserVerification,
            bankAccount: null,
            bankName: null,
            bankTransferAmount: submittedAmount.value,
            fiatSymbol: submittedAmount.currency.symbol,
            authToken: null,
            moreInfoUrl: null,
          );

          await _db.into(_db.onRampOrderRows).insert(order);

          return order.id;
        }
      });

  AsyncResult<String> createOrUpdate({
    required FiatAmount submittedAmount,
    required CryptoAmount receiveAmount,
    required String countryCode,
    required String partnerAuthPk,
    String? preOrderId,
  }) =>
      tryEitherAsync((_) async {
        {
          final orderId = await _kycRepository.createOnRampOrder(
            cryptoAmount: receiveAmount.value.toString(),
            cryptoCurrency: receiveAmount.cryptoCurrency.token.symbol,
            fiatAmount: submittedAmount.value.toString(),
            fiatCurrency: submittedAmount.currency.symbol,
            partnerPK: partnerAuthPk,
          );

          final order = OnRampOrderRow(
            id: preOrderId ?? const Uuid().v4(),
            partnerOrderId: orderId,
            amount: submittedAmount.value,
            token: Token.usdc.address,
            humanStatus: '',
            machineStatus: '',
            isCompleted: false,
            created: DateTime.now(),
            txHash: '',
            partner: RampPartner.xflow,
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
            partner: RampPartner.xflow,
            rampType: RampType.onRamp.name,
            amount: submittedAmount.value.toString(),
            countryCode: countryCode,
            id: order.id,
          );

          return order.id;
        }
      });

  // Either approve or reject
  void _waitingPartnerReviewWatcher(OnRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .listen((_) async {
      final statement = _db.update(_db.onRampOrderRows)
        ..where(
          (tbl) => tbl.id.equals(id),
        );

      final orderData = await _kycRepository.fetchOrder(order.partnerOrderId);
      final kycStatus = KycOrderStatus.fromString(orderData.status);

      final status = switch (kycStatus) {
        KycOrderStatus.completed => OnRampOrderStatus.completed,
        KycOrderStatus.unknown ||
        KycOrderStatus.rejected =>
          OnRampOrderStatus.rejected,
        KycOrderStatus.failed => OnRampOrderStatus.failure,
        KycOrderStatus.pending => OnRampOrderStatus.waitingPartnerReview,
        KycOrderStatus.accepted => OnRampOrderStatus.waitingForDeposit,
      };

      if (status != order.status) {
        await statement.write(
          OnRampOrderRowsCompanion(
            status: Value.absentIfNull(status),
            bankAccount: Value.absentIfNull(orderData.bankAccount),
            bankName: Value.absentIfNull(orderData.bankName),
            bankTransferExpiry: Value.absentIfNull(
              DateTime.now().add(const Duration(minutes: 30)),
            ),
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

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .listen((_) async {
      final statement = _db.update(_db.onRampOrderRows)
        ..where(
          (tbl) => tbl.id.equals(id),
        );

      final orderData = await _kycRepository.fetchOrder(order.partnerOrderId);
      final kycStatus = KycOrderStatus.fromString(orderData.status);

      final status = switch (kycStatus) {
        KycOrderStatus.completed => OnRampOrderStatus.completed,
        KycOrderStatus.unknown ||
        KycOrderStatus.rejected =>
          OnRampOrderStatus.rejected,
        KycOrderStatus.failed => OnRampOrderStatus.failure,
        KycOrderStatus.pending => OnRampOrderStatus.waitingPartnerReview,
        KycOrderStatus.accepted => OnRampOrderStatus.waitingForDeposit,
      };

      if (status == OnRampOrderStatus.waitingForDeposit) return;

      if (status != order.status) {
        await statement.write(
          OnRampOrderRowsCompanion(
            status: Value.absentIfNull(status),
            txHash: Value.absentIfNull(orderData.transactionId),
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

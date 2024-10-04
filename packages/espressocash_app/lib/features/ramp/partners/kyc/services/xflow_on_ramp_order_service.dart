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
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../tokens/token.dart';
import '../../../models/ramp_type.dart';

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
            case OnRampOrderStatus.waitingVerification:
              _waitingForVerificationWatcher(order);

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
          (event) => (_db.update(_db.onRampOrderRows)
                ..where((tbl) => tbl.id.equals(orderId)))
              .write(event),
        );
  }

  AsyncResult<String> create({
    required String orderId,
    required RampPartner partner,
    required CryptoAmount submittedAmount,
    required CryptoAmount? receiveAmount,
    required FiatAmount transferAmount,
    required String countryCode,
  }) =>
      tryEitherAsync((_) async {
        {
          final data = await _kycRepository.fetchOrder(orderId);

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
            receiveAmount: receiveAmount?.value,
            status: OnRampOrderStatus.waitingVerification,
            bankAccount: data.onRamp.bankAccount,
            bankName: data.onRamp.bankName,
            bankTransferAmount: transferAmount.value,
            fiatSymbol: transferAmount.currency.symbol,
            authToken: null,
            moreInfoUrl: null,
          );

          await _db.into(_db.onRampOrderRows).insert(order);
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
  void _waitingForVerificationWatcher(OnRampOrderRow order) {
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

      final data = await _kycRepository.fetchOrder(order.partnerOrderId);

      final kycStatus = KycOrderStatus.fromString(data.status);

      final status = switch (kycStatus) {
        KycOrderStatus.completed => OnRampOrderStatus.completed,
        KycOrderStatus.unknown ||
        KycOrderStatus.rejected =>
          OnRampOrderStatus.rejected,
        KycOrderStatus.failed => OnRampOrderStatus.failure,
        KycOrderStatus.pending => OnRampOrderStatus.waitingVerification,
        KycOrderStatus.accepted => OnRampOrderStatus.waitingForDeposit,
      };

      if (status != order.status) {
        await statement.write(
          OnRampOrderRowsCompanion(
            status: Value.absentIfNull(status),
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

      final data = await _kycRepository.fetchOrder(order.partnerOrderId);

      final kycStatus = KycOrderStatus.fromString(data.status);

      final status = switch (kycStatus) {
        KycOrderStatus.completed => OnRampOrderStatus.completed,
        KycOrderStatus.unknown ||
        KycOrderStatus.rejected =>
          OnRampOrderStatus.rejected,
        KycOrderStatus.failed => OnRampOrderStatus.failure,
        KycOrderStatus.pending => OnRampOrderStatus.waitingVerification,
        KycOrderStatus.accepted => OnRampOrderStatus.waitingForDeposit,
      };

      if (status == OnRampOrderStatus.waitingForDeposit) return;

      if (status != order.status) {
        await statement.write(
          OnRampOrderRowsCompanion(
            status: Value.absentIfNull(status),
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

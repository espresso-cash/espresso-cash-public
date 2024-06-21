import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../accounts/auth_scope.dart';
import '../../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../../stellar/service/stellar_client.dart';
import '../../../../data/my_database_ext.dart';
import '../../data/allbridge_client.dart';
import '../../data/allbridge_dto.dart';

@Singleton(scope: authScope)
class MoneygramOffRampPostProcessingWatcher {
  MoneygramOffRampPostProcessingWatcher(
    this._db,
    this._stellarClient,
    this._allbridgeApiClient,
  );

  final MyDatabase _db;
  final StellarClient _stellarClient;
  final AllbridgeApiClient _allbridgeApiClient;

  StreamSubscription<void>? _subscription;
  final Map<String, StreamSubscription<void>> _subscriptions = {};

  @PostConstruct()
  void init() {
    final orders = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.equalsValue(OffRampOrderStatus.postProcessing) &
            tbl.partner.equalsValue(RampPartner.moneygram),
      );

    final stream = orders.watch();

    _subscription = stream.listen((orders) {
      for (final order in orders) {
        _watch(order);
      }
    });
  }

  void _watch(OffRampOrderRow order) {
    final id = order.id;

    if (_subscriptions.containsKey(id)) {
      return;
    }

    _subscriptions[id] = Stream<void>.periodic(const Duration(seconds: 60))
        .startWith(null)
        .asyncMap(
          (_) => _db.getOffRampOrderWithStatus(
            id,
            status: OffRampOrderStatus.postProcessing,
          ),
        )
        .whereNotNull()
        .listen((order) async {
      final statement = _db.update(_db.offRampOrderRows)
        ..where(
          (tbl) =>
              tbl.id.equals(id) &
              tbl.status.equals(OnRampOrderStatus.postProcessing.name),
        );

      final hash = order.solanaBridgeTx;

      if (hash == null) {
        return;
      }

      final response = await _allbridgeApiClient.fetchBridgeStatus(
        BridgeStatusRequestDto(chain: Chain.solana, txId: hash),
      );

      final destination = response.receive;

      if (destination == null) {
        return;
      }

      final payment = await _stellarClient.getPaymentByTxId(destination.txId);

      if (payment == null) {
        return;
      }

      final receivedAmount = int.parse(destination.amount);

      await statement.write(
        OffRampOrderRowsCompanion(
          status: const Value(OffRampOrderStatus.ready),
          receiveAmount: Value(receivedAmount),
        ),
      );
    });
  }

  @disposeMethod
  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;

    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
  }
}

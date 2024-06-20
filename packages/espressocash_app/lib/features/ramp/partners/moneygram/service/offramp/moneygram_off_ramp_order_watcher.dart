import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../data/my_database_ext.dart';
import '../../../../models/ramp_watcher.dart';
import '../../data/dto.dart';
import '../../data/moneygram_client.dart';

/// Watches for [OffRampOrderStatus.waitingForPartner] Moneygram orders. 
/// Completes the order when user has taken money.
@injectable
class MoneygramOffRampOrderWatcher implements RampWatcher {
  MoneygramOffRampOrderWatcher(
    this._db,
    this._apiClient,
    this._wallet,
  );

  final MyDatabase _db;
  final MoneygramApiClient _apiClient;
  final StellarWallet _wallet;
  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    _subscription = Stream<void>.periodic(const Duration(seconds: 15))
        .startWith(null)
        .asyncMap((_) => _db.getWaitingForPartnerOffRampOrder(orderId))
        .whereNotNull()
        .listen((order) async {
      final statement = _db.update(_db.offRampOrderRows)
        ..where(
          (tbl) =>
              tbl.id.equals(orderId) &
              tbl.status.equals(OnRampOrderStatus.waitingForPartner.name),
        );
      // final String token = order.authToken ?? '';
      // final transaction = await _apiClient
      //     .fetchTransaction(
      //       id: order.partnerOrderId,
      //       authHeader: token.toAuthHeader(),
      //     )
      //     .then((e) => e.transaction);

      // final isCompleted = transaction.status == MgStatus.unknown;

      // if (isCompleted) {
      //   await _subscription?.cancel();
      //   await statement.write(
      //     OffRampOrderRowsCompanion(
      //       status: isCompleted
      //           ? const Value(OffRampOrderStatus.completed)
      //           : const Value(OffRampOrderStatus.waitingForPartner),
      //     ),
      //   );
      // }
    });
  }

  @override
  void close() {
    _subscription?.cancel();
  }
}

import 'dart:async';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/currency.dart';
import '../../../../../data/db/db.dart';
import '../../src/models/ramp_watcher.dart';
import '../data/kado_api_client.dart';

@injectable
class KadoOnRampOrderWatcher implements RampWatcher {
  KadoOnRampOrderWatcher(this._db, this._client);

  final MyDatabase _db;
  final KadoApiClient _client;

  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    _subscription = Stream<void>.periodic(const Duration(seconds: 10))
        .asyncMap(
          (_) {
            final query = _db.select(_db.onRampOrderRows)
              ..where(
                (tbl) => tbl.id.equals(orderId) & tbl.isCompleted.equals(false),
              );

            return query.getSingleOrNull();
          },
        )
        .whereNotNull()
        .asyncMap((order) => _client.getOrderStatus(order.partnerOrderId))
        .listen((event) async {
          // ignore: prefer-early-return, cannot use
          if (event.data case final data?) {
            final statement = _db.update(_db.onRampOrderRows)
              ..where(
                (tbl) => tbl.id.equals(orderId) & tbl.isCompleted.equals(false),
              );

            final isCompleted =
                data.machineStatusField == MachineStatus.settled;

            if (isCompleted) await _subscription?.cancel();

            await statement.write(
              OnRampOrderRowsCompanion(
                humanStatus: Value(data.humanStatusField),
                machineStatus: Value(data.machineStatusField.name),
                isCompleted: Value(isCompleted),
                receiveAmount: Value(
                  ((data.payAmount.amount - (data.totalFee?.amount ?? 0)) /
                          (data.quote?.price ?? 0) *
                          pow(10, Currency.usdc.decimals))
                      .toInt(),
                ),
              ),
            );
          }
        });
  }

  @override
  void close() {
    _subscription?.cancel();
  }
}

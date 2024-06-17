import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../currency/models/amount.dart';
import '../../../../../currency/models/currency.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../../stellar/service/stellar_client.dart';
import '../../../../data/my_database_ext.dart';
import '../../../../models/ramp_watcher.dart';

/// Watches for [OffRampOrderStatus.waitingForPartner] Moneygram orders. This will
/// check if money was taken by user and approved by Moneygram team
@injectable
class MoneygramOffRampOrderWatcher implements RampWatcher {
  MoneygramOffRampOrderWatcher(
    this._db,
    this._stellarClient,
    this._stellarWallet,
  );

  final MyDatabase _db;
  final StellarClient _stellarClient;
  final StellarWallet _stellarWallet;
  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    // todo implement
  }

  @override
  void close() {
    _subscription?.cancel();
  }
}

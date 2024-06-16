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
/// check if Moneygram has sent the funds to the user's Stellar account after the user
/// has deposited. It will verify the amount and memo of the payment.
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

import 'dart:async';

import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/db/db.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../../../models/ramp_watcher.dart';
import '../data/moneygram_client.dart';

@injectable
class MoneygramOnRampOrderWatcher implements RampWatcher {
  MoneygramOnRampOrderWatcher(
    this._db,
    this._moneygramClient,
    this._espressoCashClient,
    this._stellarClient,
    this._wallet,
  );

  final MyDatabase _db;
  final MoneygramApiClient _moneygramClient;
  final EspressoCashClient _espressoCashClient;
  final StellarClient _stellarClient;
  final StellarWallet _wallet;

  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    // `TODO`
    // check status if user has paid
    // if paid, verify on wallet is USDC is receieved
    // if receievd, verify if xlm balance is enough for swap
    // then call backend to do swap payment
    // sign and send transaction
    // after sometime, usdc should be receieved on solana wallet
    // update status
  }

  @override
  void close() {
    _subscription?.cancel();
  }
}

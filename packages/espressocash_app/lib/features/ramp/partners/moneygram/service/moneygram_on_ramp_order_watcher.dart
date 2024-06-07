import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../../../../data/db/db.dart';
import '../../../models/ramp_watcher.dart';

@injectable
class MoneygramOnRampOrderWatcher implements RampWatcher {
  MoneygramOnRampOrderWatcher(this._db);

  final MyDatabase _db;

  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    // TODO: implement watch
  }

  @override
  void close() {
    _subscription?.cancel();
  }
}

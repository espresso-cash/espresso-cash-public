import 'dart:async';

import 'package:async/async.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/cancelable_job.dart';
import '../../models/swap.dart';
import 'swap_repository.dart';

abstract class SwapWatcher {
  SwapWatcher(this._repository);

  final SwapRepository _repository;

  StreamSubscription<void>? _repoSubscription;
  final Map<String, CancelableOperation<void>> _operations = {};

  @protected
  Stream<IList<Swap>> watchSwaps(SwapRepository repository);

  @protected
  CancelableJob<Swap> createJob(Swap swap);

  void call({required VoidCallback onBalanceAffected}) {
    _repoSubscription =
        watchSwaps(_repository).distinct().listen((swaps) async {
      final keys = swaps.map((e) => e.id).toSet();
      for (final key in _operations.keys) {
        if (!keys.contains(key)) {
          await _operations[key]?.cancel();
        }
      }

      for (final swap in swaps) {
        final job = _operations[swap.id];
        if (job != null) return;

        _operations[swap.id] = createJob(swap).call().then((newSwap) async {
          if (swap != newSwap) {
            if (newSwap.status.affectsBalance) {
              onBalanceAffected();
            }
            await _repository.save(newSwap);
          }
          _operations.remove(swap.id);
        });
      }
    });
  }

  @mustCallSuper
  void dispose() {
    _repoSubscription?.cancel();
    for (final subscription in _operations.values) {
      subscription.cancel();
    }
  }
}

extension on SwapStatus {
  bool get affectsBalance => this.map(
        txCreated: F,
        txSent: F,
        success: T,
        txFailure: F,
      );
}

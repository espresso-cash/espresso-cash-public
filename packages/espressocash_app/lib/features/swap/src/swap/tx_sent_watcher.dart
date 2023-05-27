import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/swap.dart';
import 'swap_repository.dart';
import 'swap_watcher.dart';

/// Watches for [SwapStatus.txSent] swaps and waits for the tx to be
/// confirmed.
@injectable
class TxSentWatcher extends SwapWatcher {
  TxSentWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<Swap> createJob(Swap swap) => _SwapTxSentJob(swap, _sender);

  @override
  Stream<IList<Swap>> watchSwaps(SwapRepository repository) =>
      repository.watchTxSent();
}

class _SwapTxSentJob extends CancelableJob<Swap> {
  const _SwapTxSentJob(this.swap, this.sender);

  final Swap swap;
  final TxSender sender;

  @override
  Future<Swap?> process() async {
    final status = swap.status;
    if (status is! SwapStatusTxSent) {
      return swap;
    }

    final tx = await sender.wait(status.tx, minContextSlot: status.slot);

    final SwapStatus? newStatus = tx.map(
      success: (_) => SwapStatus.success(status.tx),
      failure: (tx) => SwapStatus.txFailure(reason: tx.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? null : swap.copyWith(status: newStatus);
  }
}

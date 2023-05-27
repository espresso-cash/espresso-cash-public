import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/cancelable_job.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/swap.dart';
import 'swap_repository.dart';
import 'swap_watcher.dart';

/// Watches for [SwapStatus.txCreated] swaps and and sends the tx.
///
/// The watcher will try to submit the tx until it's accepted or rejected.
@injectable
class TxCreatedWatcher extends SwapWatcher {
  TxCreatedWatcher(super._repository, this._sender);

  final TxSender _sender;

  @override
  CancelableJob<Swap> createJob(Swap swap) => _SwapTxCreatedJob(swap, _sender);

  @override
  Stream<IList<Swap>> watchSwaps(SwapRepository repository) =>
      repository.watchTxCreated();
}

class _SwapTxCreatedJob extends CancelableJob<Swap> {
  const _SwapTxCreatedJob(this.swap, this.sender);

  final Swap swap;
  final TxSender sender;

  @override
  Future<Swap?> process() async {
    final status = swap.status;
    if (status is! SwapStatusTxCreated) {
      return swap;
    }

    final tx = await sender.send(status.tx, minContextSlot: status.slot);

    final SwapStatus? newStatus = tx.map(
      sent: (_) => SwapStatus.txSent(
        status.tx,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => const SwapStatus.txFailure(
        reason: TxFailureReason.invalidBlockhashSending,
      ),
      failure: (it) => SwapStatus.txFailure(reason: it.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? null : swap.copyWith(status: newStatus);
  }
}

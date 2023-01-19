import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';

import 'models/swap.dart';
import 'src/swap/swap_repository.dart';

@injectable
class SwapVerifier {
  SwapVerifier(this._client, this._repository);

  final SolanaClient _client;
  final SwapRepository _repository;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  StreamSubscription<void>? _repoSubscription;

  void init() {
    _repoSubscription = _repository.watchAllPending().listen((swaps) {
      for (final swap in swaps) {
        final tx = swap.status.mapOrNull(
          txCreated: (it) => it.tx,
          txSent: (it) => it.tx,
          txSendFailure: (it) => it.tx,
          txWaitFailure: (it) => it.tx,
        );

        if (tx == null) return;

        void onSuccess(_) {
          final newStatus = SwapStatus.success(tx);
          _repository.save(swap.copyWith(status: newStatus));
          _subscriptions[swap.id]?.cancel();
          _subscriptions.remove(swap.id);
        }

        if (!_subscriptions.containsKey(swap.id)) {
          _subscriptions[swap.id] = _createStream(tx.id).listen(onSuccess);
        }
      }
    });
  }

  Stream<void> _createStream(String signature) {
    Duration backoff = const Duration(seconds: 1);

    Stream<void> streamSignatures(void _) => _client
        .waitForSignatureStatus(signature, status: Commitment.confirmed)
        .asStream();

    Stream<void> retryWhen(void _, void __) async* {
      await Future<void>.delayed(backoff);
      if (backoff < const Duration(seconds: 30)) backoff *= 2;

      yield null;
    }

    return RetryWhenStream(
      () => Stream<void>.periodic(const Duration(seconds: 10))
          .startWith(null)
          .flatMap(streamSignatures),
      retryWhen,
    );
  }

  void dispose() {
    _repoSubscription?.cancel();
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
  }
}

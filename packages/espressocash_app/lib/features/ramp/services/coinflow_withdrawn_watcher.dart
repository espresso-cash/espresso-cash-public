import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';

import '../data/coinflow_client.dart';
import '../data/coinflow_repository.dart';
import '../data/repository.dart';
import '../models/off_ramp_payment.dart';

@injectable
class CoinflowWithdrawWatcher {
  CoinflowWithdrawWatcher(
    this._client,
    this._repository, {
    @factoryParam required Ed25519HDPublicKey userPublicKey,
  }) : _userPublicKey = userPublicKey;

  final CoinflowRepository _client;
  final ORPRepository _repository;
  final Ed25519HDPublicKey _userPublicKey;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  StreamSubscription<void>? _repoSubscription;

  void init() {
    _repoSubscription =
        _repository.watchReady().distinct().listen((payments) async {
      for (final payment in payments) {
        Future<void> onSuccess(
          WithdrawResponseDataDto withdrawalDetails,
        ) async {
          if (withdrawalDetails.status != 'completed') return;

          final newStatus = ORPStatus.withdrawn(
            txId: payment.id,
            timestamp: withdrawalDetails.updatedAt,
          );

          await _repository.save(payment.copyWith(status: newStatus));
          await _subscriptions[payment.id]?.cancel();
          _subscriptions.remove(payment.id);
        }

        if (payment.provider != 'coinflow') continue;

        final status = payment.status;
        if (status is! ORPStatusSuccess) continue;

        if (!_subscriptions.containsKey(payment.id)) {
          _subscriptions[payment.id] = _createStream(
            walletId: _userPublicKey.toBase58(),
            txId: status.txId,
          ).listen(onSuccess);
        }
      }
    });
  }

  Stream<WithdrawResponseDataDto> _createStream({
    required String walletId,
    required String txId,
  }) {
    Duration backoff = const Duration(seconds: 30);

    Stream<WithdrawResponseDataDto?> streamSignatures(void _) =>
        _client.getWithdrawalStatus(txId: txId, walletId: walletId).asStream();

    Stream<void> retryWhen(void _, void __) async* {
      await Future<void>.delayed(backoff);
      if (backoff < const Duration(seconds: 120)) backoff *= 2;

      yield null;
    }

    return RetryWhenStream(
      () => Stream<void>.periodic(const Duration(seconds: 60))
          .startWith(null)
          .flatMap(streamSignatures)
          .whereNotNull()
          .where((e) => e.status != 'pending'),
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

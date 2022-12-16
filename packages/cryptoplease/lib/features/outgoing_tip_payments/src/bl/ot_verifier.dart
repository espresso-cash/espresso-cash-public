import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

import 'outgoing_tip_payment.dart';
import 'repository.dart';

@injectable
class OTVerifier {
  OTVerifier(this._client, this._repository);

  final SolanaClient _client;
  final OTRepository _repository;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  StreamSubscription<void>? _repoSubscription;

  void init() {
    _repoSubscription = _repository.watchWithReadyLink().listen((payments) {
      for (final payment in payments) {
        void onSuccess(String txId) {
          final newStatus = OTStatus.success(txId: txId);
          _repository.save(payment.copyWith(status: newStatus));
          _subscriptions[payment.id]?.cancel();
          _subscriptions.remove(payment.id);
        }

        final status = payment.status;
        if (status is! OTLinkReady) continue;

        if (!_subscriptions.containsKey(payment.id)) {
          _subscriptions[payment.id] =
              _createStream(account: status.escrow.publicKey).listen(onSuccess);
        }
      }
    });
  }

  Stream<String> _createStream({
    required Ed25519HDPublicKey account,
  }) {
    Duration backoff = const Duration(seconds: 1);

    Stream<List<TransactionSignatureInformation>> streamSignatures(void _) =>
        _client.rpcClient
            .getSignaturesForAddress(
              account.toBase58(),
              limit: 2,
              commitment: Commitment.confirmed,
            )
            .asStream();

    Stream<void> retryWhen(void _, void __) async* {
      await Future<void>.delayed(backoff);
      if (backoff < const Duration(seconds: 30)) backoff *= 2;

      yield null;
    }

    return RetryWhenStream(
      () => Stream<void>.periodic(const Duration(seconds: 10))
          .startWith(null)
          .flatMap(streamSignatures)
          .where((event) => event.length == 2)
          .map((infos) => infos.first)
          .map((info) => info.signature),
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

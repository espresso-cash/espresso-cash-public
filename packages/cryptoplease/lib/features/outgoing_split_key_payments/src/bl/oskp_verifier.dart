import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

import '../../../../core/solana_helpers.dart';
import 'outgoing_split_key_payment.dart';
import 'repository.dart';

@injectable
class OSKPVerifier {
  OSKPVerifier(
    this._client,
    this._repository, {
    @factoryParam required Ed25519HDPublicKey userPublicKey,
  }) : _userPublicKey = userPublicKey;

  final SolanaClient _client;
  final OSKPRepository _repository;
  final Ed25519HDPublicKey _userPublicKey;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  StreamSubscription<void>? _repoSubscription;

  void init() {
    _repoSubscription = _repository.watchWithReadyLinks().listen((payments) {
      for (final payment in payments) {
        Future<void> onSuccess(String txId) async {
          final newStatus = await _client.isTransactionDestination(
            signature: txId,
            address: _userPublicKey,
            mint: payment.amount.currency.token.publicKey,
          )
              ? OSKPStatus.canceled(txId: txId)
              : OSKPStatus.withdrawn(txId: txId);

          await _repository.save(payment.copyWith(status: newStatus));
          await _subscriptions[payment.id]?.cancel();
          _subscriptions.remove(payment.id);
        }

        final status = payment.status;
        if (status is! OSKPStatusLinksReady) continue;

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

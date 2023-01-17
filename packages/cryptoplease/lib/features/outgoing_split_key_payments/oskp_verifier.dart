import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../core/transactions/tx_destinations.dart';
import 'models/outgoing_split_key_payment.dart';
import 'src/bl/repository.dart';

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
        Future<void> onSuccess(SignedTx tx) async {
          final newStatus = await tx.getDestinations().let(
                    (accounts) => findAssociatedTokenAddress(
                      owner: _userPublicKey,
                      mint: payment.amount.currency.token.publicKey,
                    ).then((it) => it.toBase58()).then(accounts.contains),
                  )
              ? OSKPStatus.canceled(tx: tx)
              : OSKPStatus.withdrawn(tx: tx);

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

  Stream<SignedTx> _createStream({
    required Ed25519HDPublicKey account,
  }) {
    Duration backoff = const Duration(seconds: 1);

    Stream<Iterable<TransactionDetails>> streamSignatures(void _) =>
        _client.rpcClient
            .getTransactionsList(
              account,
              limit: 2,
              commitment: Commitment.confirmed,
              encoding: Encoding.base64,
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
          .map((details) => details.first)
          .map((tx) => tx.transaction as RawTransaction)
          .map((tx) => SignedTx.fromBytes(tx.data)),
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

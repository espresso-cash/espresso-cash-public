import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

import '../../core/callback.dart';
import '../../core/transactions/tx_destinations.dart';
import 'models/outgoing_tip_payment.dart';
import 'src/bl/repository.dart';

@injectable
class OTVerifier {
  OTVerifier(
    this._client,
    this._repository, {
    @factoryParam required Ed25519HDPublicKey userPublicKey,
    @factoryParam required Callback1<String> onSuccess,
  })  : _userPublicKey = userPublicKey,
        _onSuccess = onSuccess;

  final SolanaClient _client;
  final OTRepository _repository;
  final Ed25519HDPublicKey _userPublicKey;
  final Callback1<String> _onSuccess;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  StreamSubscription<void>? _repoSubscription;

  void init() {
    _repoSubscription = _repository.watchWithReadyLink().listen((payments) {
      for (final payment in payments) {
        Future<void> onSuccess(ParsedTransaction tx) async {
          final txId = tx.id;
          final newStatus = await tx.getDestinations().let(
                    (accounts) => findAssociatedTokenAddress(
                      owner: _userPublicKey,
                      mint: payment.amount.cryptoCurrency.token.publicKey,
                    ).then((it) => it.toBase58()).then(accounts.contains),
                  )
              ? OTStatus.canceled(txId: txId)
              : OTStatus.withdrawn(txId: txId);

          await _repository.save(payment.copyWith(status: newStatus));
          await _subscriptions[payment.id]?.cancel();
          _subscriptions.remove(payment.id);
          _onSuccess(payment.id);
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

  Stream<ParsedTransaction> _createStream({
    required Ed25519HDPublicKey account,
  }) {
    Duration backoff = const Duration(seconds: 1);

    Stream<Iterable<TransactionDetails>> streamSignatures(void _) =>
        _client.rpcClient
            .getTransactionsList(
              account,
              limit: 2,
              commitment: Commitment.confirmed,
              encoding: Encoding.jsonParsed,
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
          .map((tx) => tx.transaction as ParsedTransaction),
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

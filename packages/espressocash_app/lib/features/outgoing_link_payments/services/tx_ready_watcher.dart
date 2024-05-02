import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/account.dart';
import '../../balances/services/refresh_balance.dart';
import '../../transactions/services/tx_destinations.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';

@Singleton(scope: authScope)
class TxReadyWatcher implements Disposable {
  TxReadyWatcher(
    this._client,
    this._repository,
    this._refreshBalance, {
    required MyAccount account,
  }) : _userPublicKey = account.publicKey;

  final SolanaClient _client;
  final OLPRepository _repository;
  final Ed25519HDPublicKey _userPublicKey;
  final RefreshBalance _refreshBalance;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  StreamSubscription<void>? _repoSubscription;

  @postConstruct
  void init() {
    _repoSubscription =
        _repository.watchReady().distinct().listen((payments) async {
      for (final payment in payments) {
        Future<void> onSuccess(TransactionDetails txDetails) async {
          final tx = txDetails.transaction as ParsedTransaction;
          final txId = tx.id;

          final timestamp = txDetails.blockTime?.let(
                (it) => DateTime.fromMillisecondsSinceEpoch(it * 1000),
              ) ??
              DateTime.now();

          final IList<String> destinationAccounts =
              txDetails.getInnerDestinations();

          final newStatus = await destinationAccounts.let(
            (accounts) => findAssociatedTokenAddress(
              owner: _userPublicKey,
              mint: payment.amount.cryptoCurrency.token.publicKey,
            ).then((it) => it.toBase58()).then(accounts.contains),
          )
              ? OLPStatus.canceled(txId: txId, timestamp: timestamp)
              : OLPStatus.withdrawn(txId: txId, timestamp: timestamp);

          await _repository.save(payment.copyWith(status: newStatus));
          await _subscriptions.remove(payment.id)?.cancel();

          if (newStatus is OLPStatusCanceled) {
            _refreshBalance();
          }
        }

        final status = payment.status;
        if (status is! OLPStatusLinkReady) continue;

        if (!_subscriptions.containsKey(payment.id)) {
          final escrowAccount = await status.escrow.keyPair;

          _subscriptions[payment.id] =
              _createStream(account: escrowAccount.publicKey).listen(onSuccess);
        }
      }
    });
  }

  Stream<TransactionDetails> _createStream({
    required Ed25519HDPublicKey account,
  }) {
    Duration backoff = const Duration(seconds: 1);

    Stream<IList<TransactionDetails>> streamSignatures(void _) =>
        _client.rpcClient
            .getTransactionsList(
              account,
              limit: 100,
              commitment: Commitment.confirmed,
              encoding: Encoding.jsonParsed,
            )
            .asStream()
            .map(
              (txs) => txs
                  .where(
                    (details) => details.transaction
                        .getSignatureAccounts()
                        .contains(account),
                  )
                  .toIList(),
            );

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
          .map((details) => details.first),
      retryWhen,
    );
  }

  @override
  void onDispose() {
    _repoSubscription?.cancel();
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
  }
}

extension on Transaction {
  List<Ed25519HDPublicKey> getSignatureAccounts() => switch (this) {
        ParsedTransaction(:final signatures, :final message) => message
            .accountKeys
            .map((e) => Ed25519HDPublicKey.fromBase58(e.pubkey))
            .take(signatures.length)
            .toList(),
        RawTransaction(:final data) => SignedTx.fromBytes(data).let(
            (tx) => tx.compiledMessage.accountKeys
                .take(tx.signatures.length)
                .toList(),
          ),
        _ =>
          throw UnsupportedError('Unsupported transaction type: $runtimeType'),
      };
}

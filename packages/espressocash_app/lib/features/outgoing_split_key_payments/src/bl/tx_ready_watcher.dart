import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

import '../../../../core/api_version.dart';
import '../../../../core/transactions/tx_destinations.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'repository.dart';

@injectable
class TxReadyWatcher {
  TxReadyWatcher(
    this._client,
    this._repository, {
    @factoryParam required Ed25519HDPublicKey userPublicKey,
  }) : _userPublicKey = userPublicKey;

  final SolanaClient _client;
  final OSKPRepository _repository;
  final Ed25519HDPublicKey _userPublicKey;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  StreamSubscription<void>? _repoSubscription;

  void init({required VoidCallback onBalanceAffected}) {
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

          final IList<String> destinationAccounts;

          switch (payment.apiVersion) {
            case SplitKeyApiVersion.manual:
              destinationAccounts = tx.getDestinations();
              break;
            case SplitKeyApiVersion.smartContract:
              destinationAccounts = txDetails.getInnerDestinations();
              break;
          }

          final newStatus = await destinationAccounts.let(
            (accounts) => findAssociatedTokenAddress(
              owner: _userPublicKey,
              mint: payment.amount.cryptoCurrency.token.publicKey,
            ).then((it) => it.toBase58()).then(accounts.contains),
          )
              ? OSKPStatus.canceled(txId: txId, timestamp: timestamp)
              : OSKPStatus.withdrawn(txId: txId, timestamp: timestamp);

          await _repository.save(payment.copyWith(status: newStatus));
          await _subscriptions[payment.id]?.cancel();
          _subscriptions.remove(payment.id);

          if (newStatus is OSKPStatusCanceled) {
            onBalanceAffected();
          }
        }

        final status = payment.status;
        if (status is! OSKPStatusLinksReady) continue;

        final escrowAccount = await status.escrow.keyPair;

        if (!_subscriptions.containsKey(payment.id)) {
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
          .map((details) => details.first),
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

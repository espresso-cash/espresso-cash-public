import 'package:collection/collection.dart';
import 'package:cryptoplease/bl/activities/solana_transaction.dart';
import 'package:cryptoplease/bl/activities/tx_fetcher/bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:rxdart/subjects.dart';
import 'package:solana/solana.dart';

class MemoryTransactionRepository
    implements TxFetcherRepository, TransactionReaderRepository {
  MemoryTransactionRepository._();

  static final instance = MemoryTransactionRepository._();

  final BehaviorSubject<Map<TransactionId, SolanaTransaction>> _data =
      BehaviorSubject.seeded({});

  void dispose() {
    _data.close();
  }

  @override
  Future<bool> addIfNotExists({
    required SolanaTransaction tx,
    required Ed25519HDKeyPair account,
  }) async {
    bool wasAdded = false;
    final txs = _data.value
      ..putIfAbsent(tx.id, () => tx.also((_) => wasAdded = true));
    _data.add(txs);

    return wasAdded;
  }

  @override
  Future<void> clearAfter({
    required TransactionId id,
    required Ed25519HDKeyPair account,
  }) async {
    final txs = _data.value;
    final date = txs[id]?.blockTime;
    if (date == null) return;

    txs.removeWhere(
      (key, value) =>
          value.blockTime.isBefore(date) && value.account == account,
    );
    _data.add(txs);
  }

  @override
  Future<TransactionId?> getEarliestId({
    required Ed25519HDKeyPair account,
  }) async =>
      _data.value.values
          .sortedBy((element) => element.blockTime)
          .skip(1)
          .firstOrNull
          ?.id;

  @override
  Future<TransactionId?> getLatestId({
    required Ed25519HDKeyPair account,
  }) async =>
      _data.value.values
          .sortedBy((element) => element.blockTime)
          .reversed
          .skip(1)
          .firstOrNull
          ?.id;

  @override
  Stream<Iterable<SolanaTransaction>> watchTransactions() => _data
      .map((e) => e.values.sortedBy((element) => element.blockTime).reversed);
}

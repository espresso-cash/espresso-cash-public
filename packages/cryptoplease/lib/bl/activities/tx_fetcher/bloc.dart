import 'package:cryptoplease/bl/activities/solana_transaction.dart';
import 'package:cryptoplease/bl/processing_state.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = TxFetcherEvent;
typedef _State = TxFetcherState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

typedef AllAccountsGetter = Future<Iterable<Ed25519HDKeyPair>> Function();

abstract class TxFetcherRepository {
  Future<bool> addIfNotExists({
    required SolanaTransaction tx,
    required Ed25519HDKeyPair account,
  });

  Future<void> clearAfter({
    required TransactionId id,
    required Ed25519HDKeyPair account,
  });

  Future<TransactionId?> getLatestId({required Ed25519HDKeyPair account});

  Future<TransactionId?> getEarliestId({required Ed25519HDKeyPair account});
}

class TxFetcherBloc extends Bloc<TxFetcherEvent, TxFetcherState> {
  TxFetcherBloc({
    required TxFetcherRepository repository,
    required RpcClient client,
    required AllAccountsGetter getAllAccounts,
    @visibleForTesting int fetchLimit = 100,
  })  : _repository = repository,
        _client = client,
        _getAllAccounts = getAllAccounts,
        _fetchLimit = fetchLimit,
        super(const _State.none()) {
    on<_Event>(_eventHandler);
  }

  final TxFetcherRepository _repository;
  final RpcClient _client;
  final AllAccountsGetter _getAllAccounts;
  final int _fetchLimit;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        fetchRequested: (event) => _onFetchRequested(event, emit),
        moreRequested: (event) => _onMoreRequested(event, emit),
      );

  Future<void> _onFetchRequested(FetchRequested _, _Emitter emit) async {
    if (state.isProcessing) return;

    emit(const _State.processing());

    try {
      final accounts = await _getAllAccounts();
      final result = await accounts.map((a) async {
        final until = await _repository.getLatestId(account: a);

        return MapEntry(a, await _getSignatures(a, until: until));
      }).let(Future.wait);

      for (final item in result) {
        final account = item.key;
        final txs = item.value;

        if (txs.isEmpty) continue;

        bool hasReachedExisting = false;

        for (final tx in txs) {
          final wasAdded = await _saveTx(tx, account);

          if (!wasAdded) {
            hasReachedExisting = true;
            break;
          }
        }

        if (!hasReachedExisting) {
          await _repository.clearAfter(
            id: txs.last.signature,
            account: account,
          );
        }
      }
    } on Exception catch (e) {
      emit(_State.error(e));
      emit(const _State.none());
    }
  }

  Future<void> _onMoreRequested(MoreRequested _, _Emitter emit) async {
    if (state.isProcessing) return;

    emit(const _State.processing());

    try {
      final accounts = await _getAllAccounts();
      final result = await accounts.map((a) async {
        final before = await _repository.getEarliestId(account: a);

        return MapEntry(a, await _getSignatures(a, before: before));
      }).let(Future.wait);

      for (final item in result) {
        for (final tx in item.value) {
          final wasAdded = await _saveTx(tx, item.key);

          if (!wasAdded) break;
        }
      }
    } on Exception catch (e) {
      emit(_State.error(e));
      emit(const _State.none());
    }
  }

  Future<Iterable<TransactionSignatureInformation>> _getSignatures(
    Ed25519HDKeyPair account, {
    String? until,
    String? before,
  }) async {
    final signatures = await _client.getSignaturesForAddress(
      account.address,
      limit: _fetchLimit,
      until: until,
      before: before,
      commitment: Commitment.confirmed,
    );

    return signatures.where((e) => e.blockTime != null);
  }

  Future<bool> _saveTx(
    TransactionSignatureInformation tx,
    Ed25519HDKeyPair account,
  ) {
    // ignore: avoid-non-null-assertion, null blockTime is filtered out
    final blockTime = DateTime.fromMillisecondsSinceEpoch(tx.blockTime! * 1000);
    final transaction = SolanaTransaction(
      id: tx.signature,
      blockTime: blockTime,
      state: tx.err == null ? TxState.success : TxState.failure,
      account: account,
    );

    return _repository.addIfNotExists(tx: transaction, account: account);
  }
}

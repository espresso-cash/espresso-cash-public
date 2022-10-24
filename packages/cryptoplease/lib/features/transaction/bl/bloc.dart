import 'package:cryptoplease/core/flow.dart';
import 'package:cryptoplease/features/transaction/bl/repository.dart';
import 'package:cryptoplease/features/transaction/transaction_activity.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({
    @factoryParam required Wallet wallet,
    required SolanaClient solanaClient,
    required TransactionRepository transactionRepository,
  })  : _wallet = wallet,
        _client = solanaClient,
        _repository = transactionRepository,
        super(const TransactionState.initial()) {
    on<TransactionEvent>(_handler);
  }

  final Wallet _wallet;
  final SolanaClient _client;
  final TransactionRepository _repository;

  EventHandler<TransactionEvent, TransactionState> get _handler =>
      (event, emit) => event.map(
            fetch: (_) => _onFetch(emit),
          );

  Future<void> _onFetch(Emitter<TransactionState> emit) async {
    emit(const TransactionState.processing());

    try {
      final mostRecentActivity = await _repository.mostRecentTx();
      final mostRecentSignature = mostRecentActivity?.id;

      final signatures = await _client.rpcClient.getSignaturesForAddress(
        limit: 100,
        _wallet.address,
        until: mostRecentSignature,
      );

      if (signatures.isNotEmpty) {
        final transactions = await _client.rpcClient.getMultipleTransactions(
          signatures,
          commitment: Commitment.finalized,
          encoding: Encoding.base64,
        );

        final activities = transactions.map(_toActivity);
        await _repository.saveAll(activities);

        final hasGap = mostRecentSignature != null && activities.length == 100;

        if (hasGap) {
          await _repository.discardAndMarkAllAsFetched();
        } else {
          await _repository.markAllAsFetched();
        }
      }

      final result = await _repository.readAll();

      emit(TransactionState.success(result));
    } on Exception catch (e) {
      emit(TransactionState.failure(e));
    }
  }
}

typedef TransactionState = Flow<Exception, List<TransactionActivity>>;

@freezed
class TransactionEvent with _$TransactionEvent {
  const factory TransactionEvent.fetch() = _Fetch;
}

TransactionActivity _toActivity(TransactionDetails details) {
  final rawTx = details.transaction as RawTransaction;
  final tx = SignedTx.fromBytes(rawTx.data);

  return TransactionActivity(
    id: tx.id,
    status: const TransactionActivityStatus.pending(),
    encodedTx: tx.encode(),
    created: details.blockTime?.let(
      (blockTime) => DateTime.fromMillisecondsSinceEpoch(1000 * blockTime),
    ),
  );
}

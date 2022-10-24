import 'package:cryptoplease/core/flow.dart';
import 'package:cryptoplease/features/transaction/bl/transaction_activity_repository.dart';
import 'package:cryptoplease/features/transaction/bl/transaction_retrieved_repository.dart';
import 'package:cryptoplease/features/transaction/bl/transaction_retrieved_retrievedRepository.dart';
import 'package:cryptoplease/features/transaction/transaction_activity.dart';
import 'package:cryptoplease/features/transaction/transaction_retrieved.dart';
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
    required TransactionRetrievedRepository transactionRetrievedRepository,
    required TransactionActivityRepository transactionActivityRepository,
  })  : _wallet = wallet,
        _client = solanaClient,
        _retrievedRepository = transactionRetrievedRepository,
        _activityRepository = transactionActivityRepository,
        super(const TransactionState.initial()) {
    on<TransactionEvent>(_handler);
  }

  final Wallet _wallet;
  final SolanaClient _client;
  final TransactionRetrievedRepository _retrievedRepository;
  final TransactionActivityRepository _activityRepository;

  EventHandler<TransactionEvent, TransactionState> get _handler =>
      (event, emit) => event.map(
            fetch: (_) => _onFetch(emit),
          );

  Future<void> _onFetch(Emitter<TransactionState> emit) async {
    emit(const TransactionState.processing());

    try {
      final mostRecentActivity = await _retrievedRepository.mostRecentTx();
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

        final activities = transactions.map(_toRetrieved);
        await _retrievedRepository.saveAll(activities);

        final hasGap = mostRecentSignature != null && activities.length == 100;

        if (hasGap) {
          await _retrievedRepository.discardAndMarkAllAsFetched();
        } else {
          await _retrievedRepository.markAllAsFetched();
        }
      }

      final result = await _activityRepository.readAll();

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


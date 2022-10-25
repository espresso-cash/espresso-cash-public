import 'package:cryptoplease/core/flow.dart';
import 'package:cryptoplease/features/transaction/bl/transaction_activity_repository.dart';
import 'package:cryptoplease/features/transaction/bl/transaction_retrieved_repository.dart';
import 'package:cryptoplease/features/transaction/transaction_activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({
    @factoryParam required Wallet wallet,
    required TransactionRetrievedRepository retrievedRepository,
    required TransactionActivityRepository activityRepository,
  })  : _wallet = wallet,
        _retrievedRepository = retrievedRepository,
        _activityRepository = activityRepository,
        super(const TransactionState.initial()) {
    on<TransactionEvent>(_handler);
  }

  final Wallet _wallet;
  final TransactionRetrievedRepository _retrievedRepository;
  final TransactionActivityRepository _activityRepository;

  EventHandler<TransactionEvent, TransactionState> get _handler =>
      (event, emit) => event.map(
            fetch: (_) => _onFetch(emit),
          );

  Future<void> _onFetch(Emitter<TransactionState> emit) async {
    emit(const TransactionState.processing());

    try {
      await _retrievedRepository.fetchFromWalletAddress(_wallet.address);
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

import 'dart:io';

import 'package:cryptoplease/core/flow.dart';
import 'package:cryptoplease/features/transaction/bl/transaction_fetched.dart';
import 'package:cryptoplease/features/transaction/bl/transaction_fetched_repository.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({
    @factoryParam required Wallet wallet,
    required TransactionFetchedRepository fetchedRepository,
  })  : _wallet = wallet,
        _fetchedRepository = fetchedRepository,
        super(const TransactionState.initial()) {
    on<TransactionEvent>(_handler);
  }

  final Wallet _wallet;
  final TransactionFetchedRepository _fetchedRepository;

  EventHandler<TransactionEvent, TransactionState> get _handler =>
      (event, emit) => event.map(
            fetch: (_) => _onFetch(emit),
          );

  Future<void> _onFetch(Emitter<TransactionState> emit) async {
    emit(const TransactionState.processing());

    try {
      final transactions = await _fetchedRepository.fetch(_wallet.address);

      emit(TransactionState.success(transactions));
    } on SocketException {
      final transactions = await _fetchedRepository.readAll();

      emit(TransactionState.success(transactions));
    } on Exception catch (e) {
      emit(TransactionState.failure(e));
    }
  }
}

typedef TransactionState = Flow<Exception, IList<TransactionFetched>>;

@freezed
class TransactionEvent with _$TransactionEvent {
  const factory TransactionEvent.fetch() = _Fetch;
}

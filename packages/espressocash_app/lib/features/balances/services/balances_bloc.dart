import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:solana/solana.dart';

import '../../../core/disposable_bloc.dart';
import '../../../core/processing_state.dart';
import '../../../core/solana_helpers.dart';
import '../../authenticated/auth_scope.dart';
import '../data/balance_repository.dart';

part 'balances_bloc.freezed.dart';

final _logger = Logger('BalancesBloc');
typedef BalancesState = ProcessingState;

@Singleton(scope: authScope)
class BalancesBloc extends Bloc<BalancesEvent, BalancesState>
    with DisposableBloc {
  BalancesBloc(
    this._solanaClient,
    this._repository,
  ) : super(const ProcessingStateNone()) {
    on<BalancesEventRequested>(_handleRequested, transformer: droppable());
  }

  final SolanaClient _solanaClient;
  final BalanceRepository _repository;

  Future<void> _handleRequested(
    BalancesEventRequested event,
    Emitter<BalancesState> emit,
  ) async {
    try {
      emit(const ProcessingState.processing());

      final usdcBalance = await _solanaClient.getUsdcBalance(event.address);

      if (isClosed) return;

      emit(const ProcessingState.none());

      if (usdcBalance == null) {
        return;
      }

      _repository.save(usdcBalance);
    } on Exception catch (exception) {
      _logger.severe('Failed to fetch balances', exception);

      if (isClosed) return;

      emit(const ProcessingState.error(BalancesRequestException()));
      emit(const ProcessingState.none());
    }
  }
}

class BalancesRequestException implements Exception {
  const BalancesRequestException();
}

@freezed
sealed class BalancesEvent with _$BalancesEvent {
  const factory BalancesEvent.refreshRequested({
    required String address,
  }) = BalancesEventRequested;
}

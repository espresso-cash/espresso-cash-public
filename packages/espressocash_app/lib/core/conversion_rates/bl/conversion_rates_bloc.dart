import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../currency.dart';
import '../../processing_state.dart';
import '../../tokens/token.dart';
import 'repository.dart';

part 'conversion_rates_bloc.freezed.dart';

final _logger = Logger('ConversionRatesBloc');

typedef _Event = ConversionRatesEvent;
typedef _State = ConversionRatesState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@injectable
class ConversionRatesBloc extends Bloc<_Event, _State> {
  ConversionRatesBloc({
    required ConversionRatesRepository repository,
  })  : _repository = repository,
        super(const _State()) {
    on<_Event>(_eventHandler, transformer: restartable());
  }

  final ConversionRatesRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        refreshRequested: (event) => _onRefreshRequested(event, emit),
      );

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    _Emitter emit,
  ) async {
    emit(state.copyWith(processingState: const ProcessingState.processing()));

    await _repository.refresh(event.currency, event.tokens).doOnLeftAsync(
      (exception) {
        _logger.severe('Failed to fetch conversion rates', exception);
        const e = ConversionRatesRequestException();
        emit(state.copyWith(processingState: const ProcessingState.error(e)));
      },
    );
    emit(state.copyWith(processingState: const ProcessingState.none()));
  }
}

class ConversionRatesRequestException implements Exception {
  const ConversionRatesRequestException();
}

@freezed
class ConversionRatesEvent with _$ConversionRatesEvent {
  const factory ConversionRatesEvent.refreshRequested({
    required FiatCurrency currency,
    required Iterable<Token> tokens,
  }) = RefreshRequested;
}

@freezed
class ConversionRatesState
    with _$ConversionRatesState
    implements StateWithProcessingState {
  const factory ConversionRatesState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
  }) = _ConversionRatesState;
}

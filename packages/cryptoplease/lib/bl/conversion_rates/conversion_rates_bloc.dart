import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/processing_state.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'conversion_rates_bloc.freezed.dart';
part 'conversion_rates_event.dart';
part 'conversion_rates_state.dart';

final _logger = Logger('ConversionRatesBloc');

typedef _Event = ConversionRatesEvent;
typedef _State = ConversionRatesState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

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
        final e = ConversionRatesRequestException();
        emit(state.copyWith(processingState: ProcessingState.error(e)));
      },
    );
    emit(state.copyWith(processingState: const ProcessingState.none()));
  }
}

class ConversionRatesRequestException implements Exception {}

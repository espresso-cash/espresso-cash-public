import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../core/currency.dart';
import '../../../core/processing_state.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';

part 'conversion_rates_bloc.freezed.dart';

final _logger = Logger('ConversionRatesBloc');

typedef _Event = ConversionRatesEvent;
typedef _State = ProcessingState;
typedef _Emitter = Emitter<_State>;

@injectable
class ConversionRatesBloc extends Bloc<_Event, _State> {
  ConversionRatesBloc({
    required ConversionRatesRepository repository,
  })  : _repository = repository,
        super(const ProcessingStateNone()) {
    on<RefreshRequested>(_onRefreshRequested, transformer: restartable());
  }

  final ConversionRatesRepository _repository;

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    _Emitter emit,
  ) async {
    emit(const ProcessingState.processing());

    await _repository.refresh(event.currency, [Token.usdc]).doOnLeftAsync(
      (exception) {
        _logger.severe('Failed to fetch conversion rates', exception);
        const e = ConversionRatesRequestException();
        emit(const ProcessingState.error(e));
      },
    );
    emit(const ProcessingState.none());
  }
}

class ConversionRatesRequestException implements Exception {
  const ConversionRatesRequestException();
}

@freezed
sealed class ConversionRatesEvent with _$ConversionRatesEvent {
  const factory ConversionRatesEvent.refreshRequested({
    required FiatCurrency currency,
  }) = RefreshRequested;
}

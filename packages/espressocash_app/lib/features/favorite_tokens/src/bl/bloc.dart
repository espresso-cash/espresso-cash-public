import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/conversion_rates/bl/repository.dart';
import '../../../../core/currency.dart';
import '../../../../core/processing_state.dart';
import 'repository.dart';

part 'bloc.freezed.dart';

typedef _Event = FavoritesEvent;
typedef _State = FavoritesState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@injectable
class FavoritesBloc extends Bloc<_Event, _State> {
  FavoritesBloc({
    required ConversionRatesRepository conversionRatesRepository,
    required FavoriteTokenRepository favoriteTokenRepository,
  })  : _conversionRatesRepository = conversionRatesRepository,
        _favoriteTokenRepository = favoriteTokenRepository,
        super(const ProcessingState.none()) {
    on<_Event>(_eventHandler, transformer: restartable());
  }

  final ConversionRatesRepository _conversionRatesRepository;
  final FavoriteTokenRepository _favoriteTokenRepository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        refreshRequested: (event) => _onRefreshRequested(event, emit),
      );

  Future<void> _onRefreshRequested(RefreshRequested _, _Emitter emit) async {
    final tokens = await _favoriteTokenRepository.read();

    emit(processing());

    final newState = await _conversionRatesRepository
        .refresh(Currency.usd, tokens)
        .foldAsync(error, (_) => state);

    emit(newState);
    emit(none());
  }
}

extension FavoritesBlocExt on FavoritesBloc {
  Future<void> refresh() {
    add(const FavoritesEvent.refreshRequested());

    return stream.firstWhere((state) => !state.isProcessing);
  }
}

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.refreshRequested() = RefreshRequested;
}

typedef FavoritesState = ProcessingState<Exception>;

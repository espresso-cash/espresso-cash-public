import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/currency.dart';
import '../../../../core/processing_state.dart';
import '../../../../core/tokens/token.dart';
import 'conversion_rates_repository.dart';
import 'repository.dart';

part 'bloc.freezed.dart';

typedef _Event = FavoritesEvent;
typedef _State = FavoritesState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@injectable
class FavoritesBloc extends Bloc<_Event, _State> {
  FavoritesBloc({
    required FavoriteConversionRateRepository repository,
    required FavoriteTokenRepository favoriteTokenRepository,
  })  : _repository = repository,
        _favoriteTokenRepository = favoriteTokenRepository,
        super(const FavoritesState()) {
    on<_Event>(_eventHandler, transformer: restartable());
  }

  final FavoriteConversionRateRepository _repository;
  final FavoriteTokenRepository _favoriteTokenRepository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        refreshRequested: (event) => _onRefreshRequested(),
        fetchRates: (event) => _onFetchRates(event, emit),
      );

  Future<void> refresh() {
    add(const FavoritesEvent.refreshRequested());

    return stream.firstWhere((state) => !state.processingState.isProcessing);
  }

  Future<void> _onRefreshRequested() async {
    final tokens = await _favoriteTokenRepository.fetch();

    add(FetchRatesRequested(tokens));
  }

  Future<void> _onFetchRates(FetchRatesRequested event, _Emitter emit) async {
    emit(state.copyWith(processingState: processing()));

    final prev = state;

    final newState =
        await _repository.refresh(Currency.usd, event.tokens).foldAsync(
              (_) => state,
              (e) => state.copyWith(tokens: prev.tokens.addAll(e)),
            );

    emit(newState.copyWith(processingState: const ProcessingState.none()));
  }
}

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.refreshRequested() = RefreshRequested;
  const factory FavoritesEvent.fetchRates(Iterable<Token> tokens) =
      FetchRatesRequested;
}

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default(IMapConst<Token, Decimal?>({})) IMap<Token, Decimal?> tokens,
    @Default(ProcessingState.none()) ProcessingState<Exception> processingState,
  }) = _FavoritesState;
}

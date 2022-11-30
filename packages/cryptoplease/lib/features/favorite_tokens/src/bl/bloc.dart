import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/currency.dart';
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
        super(const IMapConst({})) {
    _initListener();

    on<_Event>(_eventHandler, transformer: restartable());
  }

  final FavoriteConversionRateRepository _repository;
  final FavoriteTokenRepository _favoriteTokenRepository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        refreshRequested: (event) => _onRefreshRequested(),
        fetchRates: (event) => _onFetchRates(event, emit),
      );

  void _initListener() {
    _favoriteTokenRepository.watch().listen((tokens) {
      add(FetchRatesRequested(tokens));
    });
  }

  Future<void> _onRefreshRequested() async {
    final tokens = await _favoriteTokenRepository.fetch();

    add(FetchRatesRequested(tokens));
  }

  Future<void> _onFetchRates(
    FetchRatesRequested event,
    _Emitter emit,
  ) async {
    final prev = state;

    final newState =
        await _repository.refresh(Currency.usd, event.tokens).foldAsync(
              (_) => state,
              prev.addAll,
            );

    emit(newState);
  }
}

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.refreshRequested() = RefreshRequested;
  const factory FavoritesEvent.fetchRates(Iterable<Token> tokens) =
      FetchRatesRequested;
}

typedef FavoritesState = IMap<Token, Decimal?>;

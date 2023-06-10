import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/currency.dart';
import '../../../../core/processing_state.dart';
import '../../../../core/tokens/token.dart';
import 'repository.dart';

part 'bloc.freezed.dart';

typedef _EventHandler = EventHandler<PopularTokenEvent, PopularTokenState>;

@injectable
class PopularTokenBloc extends Bloc<PopularTokenEvent, PopularTokenState> {
  PopularTokenBloc({
    @factoryParam required FiatCurrency userCurrency,
    required PopularTokenRepository repository,
  })  : _repository = repository,
        _userCurrency = userCurrency,
        super(const PopularTokenState()) {
    on<PopularTokenEvent>(_eventHandler, transformer: restartable());
  }

  final FiatCurrency _userCurrency;
  final PopularTokenRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        init: (event) => _onInit(emit),
        fetched: (event) => _onRefreshRequested(emit),
      );

  Future<void> _onInit(Emitter<PopularTokenState> emit) async {
    emit(PopularTokenState(processingState: processing()));

    final PopularTokenState newState =
        await _repository.get(currency: _userCurrency.symbol).let(_toState);

    emit(newState);
  }

  Future<void> _onRefreshRequested(Emitter<PopularTokenState> emit) async {
    emit(PopularTokenState(processingState: processing()));

    final PopularTokenState newState =
        await _repository.refresh(currency: _userCurrency.symbol).let(_toState);

    emit(newState);
  }

  Future<PopularTokenState> _toState(AsyncResult<IMap<Token, double>> result) =>
      result.foldAsync(
        (e) => state.copyWith(processingState: ProcessingState.error(e)),
        (tokens) => state.copyWith(
          tokens: tokens,
          processingState: const ProcessingState.none(),
        ),
      );
}

extension PopularTokenBlocExt on PopularTokenBloc {
  Future<void> refresh() {
    add(const PopularTokenEvent.fetched());

    return stream.firstWhere((state) => !state.processingState.isProcessing);
  }
}

@freezed
class PopularTokenEvent with _$PopularTokenEvent {
  const factory PopularTokenEvent.init() = Init;
  const factory PopularTokenEvent.fetched() = Fetch;
}

@freezed
class PopularTokenState with _$PopularTokenState {
  const factory PopularTokenState({
    @Default(IMapConst<Token, double>({})) IMap<Token, double> tokens,
    @Default(ProcessingState.none()) ProcessingState<Exception> processingState,
  }) = _PopularTokenState;
}

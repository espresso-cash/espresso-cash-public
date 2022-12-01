import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/currency.dart';
import '../../../../core/flow.dart';
import '../../../../core/tokens/token.dart';
import 'repository.dart';

part 'bloc.freezed.dart';

typedef _EventHandler = EventHandler<PopularTokenEvent, PopularTokenState>;

@injectable
class PopularTokenBloc extends Bloc<PopularTokenEvent, PopularTokenState> {
  PopularTokenBloc({
    @factoryParam required this.userCurrency,
    required PopularTokenRepository repository,
  })  : _repository = repository,
        super(const Flow.initial()) {
    on<PopularTokenEvent>(_eventHandler);
  }

  final FiatCurrency userCurrency;
  final PopularTokenRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        init: (event) => _onInit(emit),
        fetched: (event) => _onRefreshRequested(emit),
      );

  Future<void> _onInit(Emitter<PopularTokenState> emit) async {
    emit(const Flow.processing());

    final PopularTokenState newState = await _repository
        .get(currency: userCurrency.symbol)
        .foldAsync(Flow.failure, Flow.success);

    emit(newState);
  }

  Future<void> _onRefreshRequested(Emitter<PopularTokenState> emit) async {
    final PopularTokenState newState = await _repository
        .refresh(currency: userCurrency.symbol)
        .foldAsync(Flow.failure, Flow.success);

    emit(newState);
  }
}

@freezed
class PopularTokenEvent with _$PopularTokenEvent {
  const factory PopularTokenEvent.init() = Init;
  const factory PopularTokenEvent.fetched() = Fetch;
}

typedef PopularTokenState = Flow<Exception, IMap<Token, double>>;

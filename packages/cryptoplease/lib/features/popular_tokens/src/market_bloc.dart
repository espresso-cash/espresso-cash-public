import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/currency.dart';
import '../../../core/flow.dart';
import '../../../core/tokens/token.dart';
import 'repository.dart';

part 'market_bloc.freezed.dart';

typedef _EventHandler = EventHandler<MarketEvent, MarketDetailsState>;

@injectable
class MarketBloc extends Bloc<MarketEvent, MarketDetailsState> {
  MarketBloc({
    @factoryParam required this.userCurrency,
    required MarketDetailsRepository repository,
  })  : _repository = repository,
        super(const Flow.initial()) {
    on<MarketEvent>(_eventHandler);
  }

  final FiatCurrency userCurrency;
  final MarketDetailsRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        fetched: (event) => _onRefreshRequested(emit),
      );

  Future<void> _onRefreshRequested(Emitter<MarketDetailsState> emit) async {
    emit(const Flow.processing());

    final MarketDetailsState newState = await _repository
        .getTopMarketTokens(
          currency: userCurrency.symbol,
          noOfTokens: 20,
        )
        .foldAsync(Flow.failure, Flow.success);

    emit(newState);
  }
}

@freezed
class MarketEvent with _$MarketEvent {
  const factory MarketEvent.fetched() = MarketEventFetch;
}

typedef MarketDetailsState = Flow<Exception, Map<Token, double>>;

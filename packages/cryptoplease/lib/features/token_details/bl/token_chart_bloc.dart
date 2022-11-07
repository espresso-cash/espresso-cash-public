import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/processing_state.dart';
import '../../../core/tokens/token.dart';
import '../data/coingecko_client.dart';
import '../presentation/components/chart_widget.dart';
import 'repository.dart';

part 'token_chart_bloc.freezed.dart';
part 'token_chart_event.dart';
part 'token_chart_state.dart';

typedef _Event = TokenChartEvent;
typedef _State = TokenChartState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class TokenChartBloc extends Bloc<_Event, _State> {
  TokenChartBloc({
    required this.token,
    required TokenDetailsRepository repository,
  })  : _repository = repository,
        super(const _State(interval: ChartInterval.oneMonth)) {
    on<_Event>(_eventHandler, transformer: droppable());
  }

  final Token token;

  final TokenDetailsRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        chartRequested: (event) => _onChartRequested(event, emit),
      );

  Future<void> _onChartRequested(
    FetchChartRequested event,
    _Emitter emit,
  ) async {
    final interval = event.interval ?? state.interval;

    emit(
      state.copyWith(
        processingState: const ProcessingState.processing(),
        interval: interval,
      ),
    );

    final resp = await _repository.getMarketChart(token, interval: interval);

    emit(
      state.copyWith(
        processingState: const ProcessingState.none(),
        chart: resp ?? [],
      ),
    );
  }
}

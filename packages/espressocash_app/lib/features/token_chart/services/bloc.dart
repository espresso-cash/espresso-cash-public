import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/processing_state.dart';
import '../../../core/tokens/token.dart';
import '../data/repository.dart';
import '../models/chart_interval.dart';
import '../models/token_chart_item.dart';

part 'bloc.freezed.dart';

typedef _Event = TokenChartEvent;
typedef _State = TokenChartState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

const defaultChartInterval = ChartInterval.oneWeek;

@injectable
class TokenChartBloc extends Bloc<_Event, _State> {
  TokenChartBloc({
    @factoryParam required this.token,
    required ChartRepository repository,
  })  : _repository = repository,
        super(const _State(interval: defaultChartInterval)) {
    on<_Event>(_eventHandler, transformer: restartable());
  }

  final Token token;
  final ChartRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        chartRequested: (event) => _onChartRequested(event, emit),
      );

  Future<void> _onChartRequested(
    FetchChartRequested event,
    _Emitter emit,
  ) async {
    emit(
      state.copyWith(
        processingState: const ProcessingState.processing(),
        interval: event.interval,
      ),
    );

    final newState = await _repository
        .getMarketChart(token, interval: event.interval)
        .foldAsync(
          (_) => state.copyWith(chart: const IListConst([])),
          (result) => state.copyWith(chart: result),
        );

    emit(newState.copyWith(processingState: const ProcessingState.none()));
  }
}

@freezed
class TokenChartEvent with _$TokenChartEvent {
  const factory TokenChartEvent.chartRequested({
    required ChartInterval interval,
  }) = FetchChartRequested;
}

@freezed
class TokenChartState
    with _$TokenChartState
    implements StateWithProcessingState {
  const factory TokenChartState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
    @Default(IListConst([])) IList<TokenChartItem> chart,
    required ChartInterval interval,
  }) = _TokenChartState;
}

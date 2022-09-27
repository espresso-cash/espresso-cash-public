import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/token_info/bl/repository.dart';
import 'package:cryptoplease/features/token_info/data/coingecko_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_info_bloc.freezed.dart';
part 'token_info_event.dart';
part 'token_info_state.dart';

typedef _Event = TokenInfoEvent;
typedef _State = TokenInfoState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class TokenInfoBloc extends Bloc<_Event, _State> {
  TokenInfoBloc({
    required TokenInfoRepository repository,
  })  : _repository = repository,
        super(const _State()) {
    on<_Event>(_eventHandler, transformer: restartable());
  }

  final TokenInfoRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        fetchRequested: (event) => _onRefreshRequested(event, emit),
      );

  Future<void> _onRefreshRequested(
    FetchRequested event,
    _Emitter emit,
  ) async {
    emit(state.copyWith(processingState: const ProcessingState.processing()));

    final resp = await _repository.getMarketChart(event.token);

    emit(
      state.copyWith(
        processingState: const ProcessingState.none(),
        chart: resp ?? [],
      ),
    );
  }
}

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';

part 'swap_token_bloc.freezed.dart';
part 'swap_token_event.dart';
part 'swap_token_state.dart';

typedef _Event = SwapTokenEvent;
typedef _State = SwapTokenState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class SwapTokenBloc extends Bloc<SwapTokenEvent, SwapTokenState> {
  SwapTokenBloc({
    required this.jupiterAggregatorClient,
  }) : super(const SwapTokenState()) {
    on<_Event>(_eventHandler, transformer: sequential());
  }

  final JupiterAggregatorClient jupiterAggregatorClient;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        load: (e) => _onLoad(e, emit),
      );

  Future<void> _onLoad(SwapTokenLoadEvent _, _Emitter emit) async {
    final routeMap = await jupiterAggregatorClient.getIndexedRouteMap();
    final availableTokens = routeMap.mintKeys;

    emit(
      SwapTokenState(
        routeMap: routeMap,
      ),
    );
  }
}

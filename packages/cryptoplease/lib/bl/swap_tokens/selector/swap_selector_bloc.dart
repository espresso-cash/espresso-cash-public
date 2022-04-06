import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';

part 'swap_selector_bloc.freezed.dart';
part 'swap_selector_event.dart';
part 'swap_selector_state.dart';

typedef _Event = SwapSelectorEvent;
typedef _State = SwapSelectorState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class SwapSelectorBloc extends Bloc<_Event, _State> {
  SwapSelectorBloc({
    required TokenList tokenList,
    required JupiterAggregatorClient jupiterAggregatorClient,
  })  : _tokenList = tokenList,
        _jupiterClient = jupiterAggregatorClient,
        super(const SwapSelectorState()) {
    on<_Event>(_eventHandler, transformer: sequential());
  }

  final TokenList _tokenList;
  final JupiterAggregatorClient _jupiterClient;

  late JupiterIndexedRouteMap _routeMap;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        load: (e) => _onLoad(e, emit),
        inputSelected: (e) => _onInputSelected(e, emit),
        outputSelected: (e) => _onOutputSelected(e, emit),
      );

  Future<void> _onLoad(
    SwapSelectorLoadEvent _,
    _Emitter emit,
  ) async {
    _routeMap = await _jupiterClient.getIndexedRouteMap();

    final tokenList =
        _routeMap.mintKeys.map(_tokenList.findTokenByMint).whereNotNull();

    emit(
      state.copyWith(
        inputTokens: tokenList,
      ),
    );
  }

  Future<void> _onInputSelected(
    SwapSelectorInputEvent inputEvent,
    _Emitter emit,
  ) async {
    final mint = inputEvent.inputToken.address;
    final outputIndexes =
        _routeMap.indexedRouteMap[mint] ?? const Iterable<int>.empty();
    print(outputIndexes);
    final outputTokens =
        outputIndexes.map((index) => state.inputTokens.elementAt(index));

    print(outputTokens);

    emit(
      state.copyWith(
        outputTokens: outputTokens,
      ),
    );
  }

  Future<void> _onOutputSelected(
    SwapSelectorOutputEvent outputEvent,
    _Emitter emit,
  ) async {}
}

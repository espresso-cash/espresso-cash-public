import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/bl/processing_state.dart';
import 'package:cryptoplease/bl/swap_tokens/swap_exception.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
import 'package:rxdart/rxdart.dart';

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
    required Map<Token, Amount> balances,
  })  : _tokenList = tokenList,
        _jupiterClient = jupiterAggregatorClient,
        _balances = balances,
        super(
          SwapSelectorState(
            amount: const CryptoAmount(currency: Currency.sol, value: 0),
            slippage: Decimal.one,
          ),
        ) {
    on<_Event>(
      _eventHandler,
      transformer: (events, mapper) {
        final nonDebounceStream = events.where(
          (event) => event is! SwapSelectorAmountEvent,
        );
        final debounceStream = events
            .where((event) => event is SwapSelectorAmountEvent)
            .debounceTime(const Duration(milliseconds: 300));

        return MergeStream([nonDebounceStream, debounceStream])
            .asyncExpand(mapper);
      },
    );
  }

  final TokenList _tokenList;
  final JupiterAggregatorClient _jupiterClient;
  final Map<Token, Amount> _balances;

  late JupiterIndexedRouteMap _routeMap;
  late Iterable<Token?> _jupiterTokens;
  late Map<String, int> _mintToIndex;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        initialized: (e) => _onInitialized(e, emit),
        inputSelected: (e) => _onInputSelected(e, emit),
        outputSelected: (e) => _onOutputSelected(e, emit),
        amountUpdated: (e) => _onAmountUpdated(e, emit),
        slippageUpdated: (e) => _onSlippageUpdated(e, emit),
        swapInverted: (e) => _onSwapInverted(e, emit),
        maxInputRequested: (_) => _onMaxInputRequested(emit),
      );

  Future<void> _onInitialized(
    SwapSelectorLoadEvent _,
    _Emitter emit,
  ) async {
    emit(
      state.copyWith(
        tokenProcessingState: const ProcessingState.processing(),
      ),
    );
    try {
      _routeMap = await _jupiterClient.getIndexedRouteMap();
      _jupiterTokens = _routeMap.mintKeys.map(_tokenList.findTokenByMint);
      _mintToIndex = _routeMap.mintKeys.asMap().map((k, v) => MapEntry(v, k));
      final inputTokens = _jupiterTokens.whereNotNull().toList();

      emit(
        state.copyWith(
          inputTokens: inputTokens,
          tokenProcessingState: const ProcessingState.none(),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          tokenProcessingState: ProcessingState.error(e),
        ),
      );
    }
  }

  Future<void> _onInputSelected(
    SwapSelectorInputEvent inputEvent,
    _Emitter emit,
  ) async {
    emit(
      state.copyWith(
        selectedInput: inputEvent.inputToken,
        tokenProcessingState: const ProcessingState.processing(),
        selectedOutput: null,
        bestRoute: null,
        amount: state.amount.copyWith(
          currency: CryptoCurrency(token: inputEvent.inputToken),
        ),
      ),
    );

    final mint = inputEvent.inputToken.address;
    final index = _mintToIndex[mint].toString();
    final outputIndexes = _routeMap.indexedRouteMap[index]!;
    final outputTokens = outputIndexes
        .map((index) => _jupiterTokens.elementAt(index))
        .whereNotNull()
        .toList();

    emit(
      state.copyWith(
        outputTokens: outputTokens,
        tokenProcessingState: const ProcessingState.none(),
      ),
    );
  }

  Future<void> _onOutputSelected(
    SwapSelectorOutputEvent outputEvent,
    _Emitter emit,
  ) async {
    final outputToken = outputEvent.outputToken;

    emit(
      state.copyWith(
        selectedOutput: outputToken,
        bestRoute: null,
      ),
    );

    await _onRouteRefreshed(emit);
  }

  Future<void> _onSlippageUpdated(
    SwapSelectorSlippageEvent slippageEvent,
    _Emitter emit,
  ) async {
    emit(
      state.copyWith(
        slippage: slippageEvent.slippage,
      ),
    );

    await _onRouteRefreshed(emit);
  }

  Future<void> _onAmountUpdated(
    SwapSelectorAmountEvent amountEvent,
    _Emitter emit,
  ) async {
    if (amountEvent.decimal == state.amount.decimal) return;

    final tokenValue = state.amount.currency.decimalToInt(amountEvent.decimal);
    final tokenAmount = state.amount.copyWith(value: tokenValue);

    emit(
      state.copyWith(
        amount: tokenAmount,
        bestRoute: null,
      ),
    );

    await _onRouteRefreshed(emit);
  }

  Future<void> _onSwapInverted(
    SwapSelectorInvertEvent event,
    _Emitter emit,
  ) async {}

  Future<void> _onMaxInputRequested(_Emitter emit) async {
    final input = state.selectedInput;

    if (input == null) return;

    final entry = _balances.entries.firstWhere(
      (entry) => entry.key.address == input.address,
      orElse: () => MapEntry(
        input,
        CryptoAmount(
          value: 10,
          currency: CryptoCurrency(token: input),
        ),
      ),
    );

    final amount = entry.value.map(
      crypto: identity,
      fiat: (f) => CryptoAmount(
        value: f.value,
        currency: CryptoCurrency(token: input),
      ),
    );

    emit(
      state.copyWith(
        amount: amount,
      ),
    );

    await _onRouteRefreshed(emit);
  }

  Future<void> _onRouteRefreshed(
    _Emitter emit,
  ) async {
    final selectedInput = state.selectedInput;
    final selectedOutput = state.selectedOutput;
    final amount = state.amount.value;

    if (selectedInput == null || selectedOutput == null) return;

    if (amount == 0) {
      return emit(
        state.copyWith(
          bestRoute: null,
        ),
      );
    }

    try {
      emit(
        state.copyWith(
          routeProcessingState: const ProcessingState.processing(),
        ),
      );

      final routes = await _jupiterClient.getQuote(
        amount: amount,
        inputMint: selectedInput.address,
        outputMint: selectedOutput.address,
        slippage: state.slippage.toDouble(),
      );

      if (routes.isEmpty) {
        throw const SwapExcetion(SwapFailReason.routeNotFound);
      }

      final route = routes.first;

      emit(
        state.copyWith(
          bestRoute: route,
          routeProcessingState: const ProcessingState.none(),
        ),
      );
    } on SwapExcetion catch (e) {
      emit(
        state.copyWith(
          routeProcessingState: ProcessingState.error(e),
        ),
      );
    }
  }

  Either<ValidationError, void> validate() {
    final token = state.selectedInput;
    if (token == null) return const Either.right(null);

    final entry = _balances.entries.firstWhereOrNull(
      (entry) => entry.key.address == token.address,
    );
    final userBalance =
        entry?.value ?? Amount.zero(currency: Currency.crypto(token: token));

    if (userBalance < state.amount) {
      return Either.left(
        ValidationError.insufficientFunds(
          balance: userBalance,
          currentAmount: state.amount,
        ),
      );
    }

    return const Either.right(null);
  }
}

import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/bl/processing_state.dart';
import 'package:cryptoplease/bl/swap_tokens/swap_exception.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/config.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
import 'package:rxdart/rxdart.dart';

part 'swap_selector_bloc.freezed.dart';
part 'swap_selector_event.dart';
part 'swap_selector_state.dart';
part 'swap_selector_transformer.dart';

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
    on<_Event>(_eventHandler, transformer: debounceAmountOnly());
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
        swapInverted: (_) => _onSwapInverted(emit),
        maxInputRequested: (_) => _onMaxInputRequested(emit),
      );

  Future<void> _onInitialized(
    SwapSelectorLoadEvent _,
    _Emitter emit,
  ) async {
    emit(
      SwapSelectorState(
        amount: const CryptoAmount(currency: Currency.sol, value: 0),
        slippage: Decimal.one,
      ).invalidateRoute(),
    );

    try {
      _routeMap = await _jupiterClient.getIndexedRouteMap();

      // Replace Wrapped SOL with SOl in token list
      final mintKeys = _routeMap.mintKeys;
      final wrappedIndex = mintKeys.indexOf(Token.wrappedSol.address);
      if (wrappedIndex != -1) {
        mintKeys
          ..removeAt(wrappedIndex)
          ..insert(wrappedIndex, Token.sol.address);
      }

      _jupiterTokens = mintKeys.map(_tokenList.findTokenByMint);
      _mintToIndex = mintKeys.asMap().map((k, v) => MapEntry(v, k));

      final inputTokens = _jupiterTokens
          .whereNotNull()
          .where(_balances.isPositive)
          .toList()
        ..sortByName();

      emit(
        state.copyWith(
          inputTokens: inputTokens,
          tokenProcessingState: const ProcessingState.none(),
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(tokenProcessingState: ProcessingState.error(e)));
    }
  }

  Future<void> _onInputSelected(
    SwapSelectorInputEvent inputEvent,
    _Emitter emit,
  ) async {
    emit(
      state.copyWith(
        selectedInput: inputEvent.inputToken,
        bestRoute: null,
        selectedOutput: null,
        outputTokens: _validOutputsForInput(inputEvent.inputToken),
        tokenProcessingState: const ProcessingState.none(),
        amount: state.amount.copyWith(
          currency: CryptoCurrency(token: inputEvent.inputToken),
        ),
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
        tokenProcessingState: const ProcessingState.none(),
        bestRoute: null,
      ),
    );

    await _onRouteRefreshed(emit);
  }

  Future<void> _onSlippageUpdated(
    SwapSelectorSlippageEvent slippageEvent,
    _Emitter emit,
  ) async {
    if (slippageEvent.slippage == state.slippage) return;

    emit(state.copyWith(slippage: slippageEvent.slippage));

    await _onRouteRefreshed(emit);
  }

  Future<void> _onAmountUpdated(
    SwapSelectorAmountEvent amountEvent,
    _Emitter emit,
  ) async {
    if (amountEvent.decimal == state.amount.decimal) return;

    final tokenValue = state.amount.currency.decimalToInt(amountEvent.decimal);
    final tokenAmount = state.amount.copyWith(value: tokenValue);

    emit(state.copyWith(amount: tokenAmount, bestRoute: null));

    await _onRouteRefreshed(emit);
  }

  Future<void> _onSwapInverted(_Emitter emit) async {
    final newInput = state.selectedOutput;
    final oldInput = state.selectedInput;

    if (newInput == null || oldInput == null) return;

    emit(state.invalidateRoute());

    final outputTokens = _validOutputsForInput(newInput);
    final newOutput = outputTokens.contains(oldInput) ? oldInput : null;
    final amount = state.amount
        .copyWith(currency: CryptoCurrency(token: newInput))
        .copyWithDecimal(state.amount.decimal);

    emit(
      state.copyWith(
        selectedInput: newInput,
        selectedOutput: newOutput,
        amount: amount,
        outputTokens: outputTokens,
        tokenProcessingState: const ProcessingState.none(),
      ),
    );

    await _onRouteRefreshed(emit);
  }

  Future<void> _onMaxInputRequested(_Emitter emit) async {
    final input = state.selectedInput;

    if (input == null) return;

    var balance = _balances.balanceFromToken(input);

    if (input.isWrappedSol || input.isSolana) {
      final fee = calculateFeeForWrappedSol();
      balance = balance.copyWith(
        value: math.max(0, balance.value - fee.value),
      );
    }

    emit(state.copyWith(amount: balance));

    await _onRouteRefreshed(emit);
  }

  Future<void> _onRouteRefreshed(
    _Emitter emit,
  ) async {
    final selectedInput = state.selectedInput;
    final selectedOutput = state.selectedOutput;

    if (selectedInput == null || selectedOutput == null) return;

    final amount = state.amount.value;
    if (amount == 0) {
      return emit(
        state.invalidateRoute(isProcessingNewRoute: false),
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
        inputMint: selectedInput.isSolana
            ? Token.wrappedSol.address
            : selectedInput.address,
        outputMint: selectedOutput.isSolana
            ? Token.wrappedSol.address
            : selectedOutput.address,
        slippage: state.slippage.toDouble(),
      );

      if (routes.isEmpty) {
        throw const SwapExcetion(SwapFailReason.routeNotFound);
      }

      emit(
        state.copyWith(
          bestRoute: routes.first,
          routeProcessingState: const ProcessingState.none(),
        ),
      );
    } on SwapExcetion catch (e) {
      emit(state.copyWith(routeProcessingState: ProcessingState.error(e)));
    }
  }

  List<Token> _validOutputsForInput(Token token) {
    final index = _mintToIndex[token.address].toString();
    final outputIndexes = _routeMap.indexedRouteMap[index];

    if (outputIndexes == null) return List<Token>.empty();

    return outputIndexes
        .map((index) => _jupiterTokens.elementAt(index))
        .whereNotNull()
        .toList()
      ..sortByName();
  }

  Either<ValidationError, void> validate() {
    final token = state.selectedInput;
    if (token == null) return const Either.right(null);

    final userBalance = _balances.balanceFromToken(token);

    if (userBalance < state.amount) {
      return Either.left(
        ValidationError.insufficientFunds(
          balance: userBalance,
          currentAmount: state.amount,
        ),
      );
    }

    if (token.isSolana || token.isWrappedSol) {
      final fee = calculateFeeForWrappedSol();

      var feeBalance =
          _balances[Token.sol] ?? Amount.zero(currency: Currency.sol);

      feeBalance = feeBalance.copyWith(
        value: feeBalance.value - state.amount.value,
      );

      if (feeBalance < fee) {
        return Either.left(ValidationError.insufficientFee(fee));
      }
    }

    return const Either.right(null);
  }
}

extension on _State {
  _State invalidateRoute({
    bool isProcessingNewRoute = true,
  }) =>
      copyWith(
        bestRoute: null,
        tokenProcessingState: isProcessingNewRoute
            ? const ProcessingState.processing()
            : const ProcessingState.none(),
      );
}

extension on Map<Token, Amount?> {
  bool isPositive(Token token) {
    final balance = this[token];

    return balance != null && balance.value != 0;
  }

  CryptoAmount balanceFromToken(Token token) {
    final balance = this[token];
    final value = balance?.value ?? 0;

    return CryptoAmount(
      value: value,
      currency: CryptoCurrency(token: token),
    );
  }
}

extension on List<Token> {
  void sortByName() => sorted((a, b) => a.name.compareTo(b.name));
}

extension on Token {
  bool get isWrappedSol => address == Token.wrappedSol.address;
}

CryptoAmount calculateFeeForWrappedSol() {
  // Base fee for the transaction multiplied by 3, once it's the max of
  // transactions that might happen
  const fee = 3 * (lamportsPerSignature + tokenProgramRent);

  return const CryptoAmount(value: fee, currency: Currency.sol);
}

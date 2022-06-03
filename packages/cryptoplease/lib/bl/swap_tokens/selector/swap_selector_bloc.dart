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
        super(const SwapSelectorState.uninitialized()) {
    on<_Event>(_eventHandler, transformer: debounceAmountOnly());
  }

  final TokenList _tokenList;
  final JupiterAggregatorClient _jupiterClient;
  final Map<Token, Amount> _balances;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        init: (e) => _onInit(e, emit),
        inputUpdated: (e) => _onInputUpdated(e, emit),
        outputUpdated: (e) => _onOutputUpdated(e, emit),
        outputInvalidated: (e) => _onOutputInvalidated(e, emit),
        amountUpdated: (e) => _onAmountUpdated(e, emit),
        slippageUpdated: (e) => _onSlippageUpdated(e, emit),
        swapInverted: (e) => _onSwapInverted(e, emit),
      );

  Iterable<Token> _getOutputTokens(
    JupiterIndexedRouteMap routeMap,
    Token input,
  ) =>
      routeMap
          .indexedRouteMap[routeMap.mintKeys.indexOf(input.address).toString()]!
          .map((route) => routeMap.mintKeys[route])
          .map(_tokenList.findTokenByMint)
          .whereNotNull()
          .sortedByName();

  Future<void> _onInit(Init _, _Emitter emit) async {
    if (state is! Uninitialized) return;

    try {
      final routeMap = await _jupiterClient.getIndexedRouteMap();

      final mintKeys = routeMap.mintKeys;
      final jupiterTokens = mintKeys.map(_tokenList.findTokenByMint);

      final inputTokens = jupiterTokens
          .whereNotNull()
          .where(_balances.isPositive)
          .sortedByName();

      final token = inputTokens.first;
      final outputTokens = _getOutputTokens(routeMap, token);

      final state = SwapSelectorState.initialized(
        amount: CryptoAmount(
          currency: CryptoCurrency(token: token),
          value: 0,
        ),
        slippage: Decimal.one,
        output: outputTokens.first,
        outputTokens: outputTokens,
        inputTokens: inputTokens,
        routeMap: routeMap,
      );

      emit(state);
    } on Exception catch (e) {
      emit(const SwapSelectorState.failure());
    }
  }

  Future<void> _onOutputInvalidated(OutputInvalidated _, _Emitter emit) async {
    final state = this.state;
    if (state is! Initialized) return;

    if (state.amount.value == 0) {
      emit(state.copyWith(bestRoute: null));

      return;
    }

    emit(
      state.copyWith(processingState: const ProcessingState.processing()),
    );

    try {
      final routes = await _jupiterClient.getQuote(
        amount: state.amount.value,
        inputMint: state.input.address,
        outputMint: state.output.address,
        slippage: state.slippage.toDouble(),
      );

      if (routes.isEmpty) {
        throw const SwapException(SwapFailReason.routeNotFound);
      }

      emit(
        state.copyWith(
          bestRoute: routes.first,
          processingState: const ProcessingState.none(),
        ),
      );
    } on SwapException catch (e) {
      emit(
        state.copyWith(
          processingState: ProcessingState.error(e),
          bestRoute: null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          processingState: ProcessingState.error(
            SwapException(SwapFailReason.unknown, exception: e),
          ),
          bestRoute: null,
        ),
      );
    }
  }

  Future<void> _onInputUpdated(InputUpdated event, _Emitter emit) async {
    final state = this.state;
    if (state is! Initialized) return;

    emit(
      state.copyWith(
        amount: state.amount.copyWith(
          currency: CryptoCurrency(token: event.token),
        ),
        outputTokens: _getOutputTokens(state.routeMap, event.token),
        bestRoute: null,
      ),
    );

    add(const SwapSelectorEvent.outputInvalidated());
  }

  Future<void> _onOutputUpdated(OutputUpdated event, _Emitter emit) async {
    final state = this.state;
    if (state is! Initialized) return;

    emit(state.copyWith(output: event.token));

    add(const SwapSelectorEvent.outputInvalidated());
  }

  Future<void> _onSlippageUpdated(SlippageUpdated event, _Emitter emit) async {
    final state = this.state;
    if (state is! Initialized) return;

    emit(state.copyWith(slippage: event.slippage));

    add(const SwapSelectorEvent.outputInvalidated());
  }

  Future<void> _onAmountUpdated(AmountUpdated event, _Emitter emit) async {
    final state = this.state;
    if (state is! Initialized) return;

    emit(state.copyWith(amount: state.amount.copyWithDecimal(event.decimal)));

    add(const SwapSelectorEvent.outputInvalidated());
  }

  Future<void> _onSwapInverted(SwapInverted _, _Emitter emit) async {
    final state = this.state;
    if (state is! Initialized) return;

    final newInput = state.output;
    final oldInput = state.input;

    final outputTokens = _getOutputTokens(state.routeMap, newInput);
    final newOutput =
        outputTokens.contains(oldInput) ? oldInput : outputTokens.first;
    final amount = state.amount
        .copyWith(currency: CryptoCurrency(token: newInput))
        .copyWithDecimal(state.amount.decimal);

    emit(
      state.copyWith(
        amount: amount,
        output: newOutput,
        outputTokens: outputTokens,
      ),
    );

    add(const SwapSelectorEvent.outputInvalidated());
  }

  // Future<void> _onMaxInputRequested(_Emitter emit) async {
  //   final input = state.selectedInput;

  //   if (input == null) return;

  //   var balance = _balances.balanceFromToken(input);

  //   if (input.isWrappedSol || input.isSolana) {
  //     final fee = calculateFeeForWrappedSol();
  //     balance = balance.copyWith(
  //       value: math.max(0, balance.value - fee.value),
  //     );
  //   }

  //   emit(state.copyWith(amount: balance));

  //   await _onRouteRefreshed(emit);
  // }

  // Either<ValidationError, void> validate() {
  //   final token = state.selectedInput;
  //   if (token == null) return const Either.right(null);

  //   final userBalance = _balances.balanceFromToken(token);

  //   if (userBalance < state.amount) {
  //     return Either.left(
  //       ValidationError.insufficientFunds(
  //         balance: userBalance,
  //         currentAmount: state.amount,
  //       ),
  //     );
  //   }

  //   if (token.isSolana || token.isWrappedSol) {
  //     final fee = calculateFeeForWrappedSol();

  //     var feeBalance =
  //         _balances[Token.sol] ?? Amount.zero(currency: Currency.sol);

  //     feeBalance = feeBalance.copyWith(
  //       value: feeBalance.value - state.amount.value,
  //     );

  //     if (feeBalance < fee) {
  //       return Either.left(ValidationError.insufficientFee(fee));
  //     }
  //   }

  //   return const Either.right(null);
  // }
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

extension on Iterable<Token> {
  List<Token> sortedByName() => sorted((a, b) => a.name.compareTo(b.name));
}

extension on Token {
  bool get isWrappedSol => address == Token.wrappedSol.address;
}

CryptoAmount calculateFeeForWrappedSol() {
  // Base fee for the transaction multiplied by 3 since it's the max of
  // transactions that might happen
  const fee = 3 * (lamportsPerSignature + tokenProgramRent);

  return const CryptoAmount(value: fee, currency: Currency.sol);
}

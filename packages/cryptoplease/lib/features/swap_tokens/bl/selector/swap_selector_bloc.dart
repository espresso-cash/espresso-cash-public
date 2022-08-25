import 'package:collection/collection.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/analytics/analytics_manager.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/features/swap_tokens/bl/swap_exception.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
import 'package:rxdart/rxdart.dart';

part 'swap_selector_bloc.freezed.dart';
part 'swap_selector_event.dart';
part 'swap_selector_state.dart';

typedef _Event = SwapSelectorEvent;
typedef _State = SwapSelectorState;
typedef _Emitter = Emitter<_State>;

class SwapSelectorBloc extends Bloc<_Event, _State> {
  SwapSelectorBloc({
    required TokenList tokenList,
    required JupiterAggregatorClient jupiterAggregatorClient,
    required Map<Token, Amount> balances,
    required AnalyticsManager analyticsManager,
  })  : _tokenList = tokenList,
        _jupiterClient = jupiterAggregatorClient,
        _balances = balances.lock.add(
          Token.wrappedSol,
          balances[Token.sol] ??
              Amount.zero(
                currency: const Currency.crypto(token: Token.wrappedSol),
              ),
        ),
        _analyticsManager = analyticsManager,
        super(const SwapSelectorState.uninitialized()) {
    on<Init>(_onInit);
    on<InputUpdated>(_onInputUpdated);
    on<OutputUpdated>(_onOutputUpdated);
    on<SlippageUpdated>(_onSlippageUpdated);
    on<AmountUpdated>(_onAmountUpdated);
    on<SwapInverted>(_onSwapInverted);
    on<OutputInvalidated>(
      _onOutputInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
    on<Submitted>(_onSubmitted);
  }

  final TokenList _tokenList;
  final JupiterAggregatorClient _jupiterClient;
  final IMap<Token, Amount> _balances;
  final AnalyticsManager _analyticsManager;

  CryptoAmount? calculateMaxAmount() => state.maybeMap(
        initialized: (state) => state.calculateMaxAmount(_balances),
        orElse: () => null,
      );

  Future<void> _onInit(Init _, _Emitter emit) async {
    if (state is! Uninitialized && state is! Success) return;

    try {
      final routeMap = await _jupiterClient.getIndexedRouteMap();

      final mintKeys = routeMap.mintKeys;
      final jupiterTokens = mintKeys.map(_tokenList.findTokenByMint);

      final inputTokens = await compute(
        _computeInputTokens,
        _Input(tokens: jupiterTokens, balances: _balances),
      );

      final token = inputTokens.firstWhere(
        (token) => token.isSolana,
        orElse: () => inputTokens.first,
      );

      final outputTokens = await _getOutputTokens(routeMap, token);

      final output = outputTokens.firstWhere(
        (token) => token.symbol.toLowerCase() == 'usdc',
        orElse: () => outputTokens.first,
      );

      final state = SwapSelectorState.initialized(
        amount: CryptoAmount(currency: CryptoCurrency(token: token), value: 0),
        slippage: Decimal.one,
        output: output,
        outputTokens: outputTokens,
        inputTokens: inputTokens,
        routeMap: routeMap,
      );

      emit(state);
    } on Exception catch (_) {
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

    emit(state.copyWith(processingState: processing()));

    try {
      final routes = await _jupiterClient.getQuote(
        amount: state.amount.value,
        inputMint: state.input.forJupiter.address,
        outputMint: state.output.forJupiter.address,
        slippage: state.slippage.toDouble(),
      );

      if (routes.isEmpty) throw const SwapException.routeNotFound();

      emit(state.copyWith(bestRoute: routes.first, processingState: none()));
    } on SwapException catch (e) {
      emit(state.copyWith(processingState: error(e), bestRoute: null));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          processingState: error(SwapException.other(e)),
          bestRoute: null,
        ),
      );
    }
  }

  Future<void> _onInputUpdated(InputUpdated event, _Emitter emit) async =>
      _updateInput((state) async {
        final amount = state.amount.copyWith(
          currency: CryptoCurrency(token: event.token),
        );

        final outputTokens =
            await _getOutputTokens(state.routeMap, event.token);

        final newState = state.copyWith(
          amount: amount,
          outputTokens: outputTokens,
          bestRoute: null,
        );
        emit(newState);
      });

  Future<void> _onOutputUpdated(OutputUpdated event, _Emitter emit) async =>
      _updateInput((state) async {
        emit(state.copyWith(output: event.token));
      });

  Future<void> _onSlippageUpdated(SlippageUpdated event, _Emitter emit) async =>
      _updateInput((state) async {
        emit(state.copyWith(slippage: event.slippage));
      });

  Future<void> _onAmountUpdated(AmountUpdated event, _Emitter emit) async =>
      _updateInput((state) async {
        emit(
          state.copyWith(amount: state.amount.copyWithDecimal(event.decimal)),
        );
      });

  Future<void> _onSwapInverted(SwapInverted _, _Emitter emit) async =>
      _updateInput((state) async {
        final newInput = state.output;
        final oldInput = state.input;

        final outputTokens = await _getOutputTokens(state.routeMap, newInput);
        final newOutput =
            outputTokens.contains(oldInput) ? oldInput : outputTokens.first;

        final newInputAmount = state.amount.copyWith(
          currency: CryptoCurrency(token: newInput),
          value: state.bestRoute?.outAmount ?? 0,
        );

        final newState = state.copyWith(
          amount: newInputAmount,
          output: newOutput,
          outputTokens: outputTokens,
        );
        emit(newState);
      });

  Future<void> _onSubmitted(Submitted _, _Emitter emit) async {
    final state = this.state;
    if (state is! Initialized) return;

    state.validate(_balances).fold(
      (e) {
        emit(state.copyWith(processingState: error(e)));
        emit(state.copyWith(processingState: none()));
      },
      (s) {
        _analyticsManager.swapTransactionCreated(
          from: state.input.symbol,
          to: state.output.symbol,
          amount: state.amount.value,
        );
        emit(_State.success(s));
      },
    );
  }

  Future<Iterable<Token>> _getOutputTokens(
    JupiterIndexedRouteMap routeMap,
    Token input,
  ) =>
      compute(
        _computeOutputTokens,
        _Output(map: routeMap, input: input, tokenList: _tokenList),
      );

  Future<void> _updateInput(
    Future<void> Function(Initialized state) block,
  ) async {
    final state = this.state;
    if (state is! Initialized) return;

    await block(state);

    add(const _Event.outputInvalidated());
  }
}

class _Input {
  _Input({required this.tokens, required this.balances});

  final Iterable<Token?> tokens;
  final IMap<Token, Amount> balances;
}

List<Token> _computeInputTokens(_Input input) => input.tokens
    .whereNotNull()
    .map((t) => t == Token.wrappedSol ? Token.sol : t)
    .where(input.balances.isPositive)
    .sortedByName();

class _Output {
  _Output({required this.map, required this.input, required this.tokenList});

  final JupiterIndexedRouteMap map;
  final Token input;
  final TokenList tokenList;
}

Iterable<Token> _computeOutputTokens(_Output output) {
  final index =
      output.map.mintKeys.indexOf(output.input.forJupiter.address).toString();

  return output.map.indexedRouteMap[index]!
      .map((route) => output.map.mintKeys[route])
      .map(output.tokenList.findTokenByMint)
      .map((t) => t == Token.wrappedSol ? Token.sol : t)
      .whereNotNull()
      .sortedByName();
}

extension on IMap<Token, Amount?> {
  bool isPositive(Token token) {
    final balance = this[token];

    return balance != null && balance.value > 0;
  }

  CryptoAmount balanceFromToken(Token token) {
    final balance = this[token];
    final value = balance?.value ?? 0;

    return CryptoAmount(value: value, currency: CryptoCurrency(token: token));
  }
}

extension on Iterable<Token> {
  List<Token> sortedByName() => sorted((a, b) => a.name.compareTo(b.name));
}

extension on Token {
  Token get forJupiter => this == Token.sol ? Token.wrappedSol : this;
}

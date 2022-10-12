import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/analytics/analytics_manager.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/features/swap/bl/create_swap/balances.dart';
import 'package:cryptoplease/features/swap/bl/create_swap/swap_exception.dart';
import 'package:cryptoplease/features/swap/bl/swap_setup.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = CreateSwapEvent;
typedef _State = CreateSwapState;
typedef _Emitter = Emitter<_State>;

class CreateSwapBloc extends Bloc<_Event, _State> {
  CreateSwapBloc({
    required TokenList tokenList,
    required JupiterAggregatorClient jupiterAggregatorClient,
    required Balances balances,
    required SwapSetup initialSetup,
    required AnalyticsManager analyticsManager,
  })  : _tokenList = tokenList,
        _initialSetup = initialSetup,
        _jupiterClient = jupiterAggregatorClient,
        _balances = balances.add(
          Token.wrappedSol,
          balances[Token.sol] ??
              Amount.zero(
                currency: const Currency.crypto(token: Token.wrappedSol),
              ),
        ),
        _analyticsManager = analyticsManager,
        super(const CreateSwapState.none()) {
    on<Init>(_onInit);
    on<OutputUpdated>(_onOutputUpdated);
    on<SlippageUpdated>(_onSlippageUpdated);
    on<AmountUpdated>(_onAmountUpdated);
    on<OutputInvalidated>(
      _onOutputInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
    on<Submitted>(_onSubmitted);
  }

  final SwapSetup _initialSetup;
  final TokenList _tokenList;
  final JupiterAggregatorClient _jupiterClient;
  final Balances _balances;
  final AnalyticsManager _analyticsManager;

  CryptoAmount? calculateMaxAmount() => state.maybeMap(
        initialized: (state) => state.calculateMaxAmount(_balances),
        orElse: () => null,
      );

  Future<void> _onInit(Init _, _Emitter emit) async {
    final hasInitialized = state.maybeMap(none: T, success: T, orElse: F);
    if (hasInitialized) return;

    try {
      final routeMap = await _jupiterClient.getIndexedRouteMap();

      final mintKeys = routeMap.mintKeys;
      final jupiterTokens = mintKeys.map(_tokenList.findTokenByMint);

      final inputTokens = await compute(
        _computeInputTokens,
        _Input(tokens: jupiterTokens, balances: _balances),
      );

      final token = inputTokens.firstWhere(
        (token) => token == _initialSetup.inputToken,
        orElse: () => inputTokens.first,
      );

      final outputTokens = await _getOutputTokens(routeMap, token);

      final output = outputTokens.firstWhere(
        (token) => token == _initialSetup.outputToken,
        orElse: () => outputTokens.first,
      );

      final state = CreateSwapState.initialized(
        inputAmount:
            CryptoAmount(currency: CryptoCurrency(token: token), value: 0),
        slippage: _initialSetup.slippage,
        output: output,
        outputTokens: outputTokens,
        routeMap: routeMap,
      );

      emit(state);
    } on Exception catch (_) {
      emit(const CreateSwapState.failure());
    }
  }

  Future<void> _onOutputInvalidated(OutputInvalidated _, _Emitter emit) async =>
      state.mapOrNull(
        initialized: (state) async {
          if (state.inputAmount.value == 0) {
            emit(state.copyWith(bestRoute: null));

            return;
          }

          emit(state.copyWith(processingState: processing()));

          try {
            final routes = await _jupiterClient.getQuote(
              amount: state.inputAmount.value,
              inputMint: state.input.forJupiter.address,
              outputMint: state.output.forJupiter.address,
              slippage: state.slippage.toDouble(),
            );

            if (routes.isEmpty) throw const SwapException.routeNotFound();

            emit(
              state.copyWith(
                bestRoute: routes.first,
                processingState: none(),
              ),
            );
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
        },
      );

  Future<void> _onOutputUpdated(OutputUpdated event, _Emitter emit) async =>
      _updateInput((state) {
        emit(state.copyWith(output: event.token));
      });

  Future<void> _onSlippageUpdated(SlippageUpdated event, _Emitter emit) async =>
      _updateInput((state) {
        emit(state.copyWith(slippage: event.slippage));
      });

  Future<void> _onAmountUpdated(AmountUpdated event, _Emitter emit) async =>
      _updateInput((state) {
        emit(
          state.copyWith(
            inputAmount: state.inputAmount.copyWithDecimal(event.decimal),
          ),
        );
      });

  Future<void> _onSubmitted(Submitted _, _Emitter emit) async =>
      state.mapOrNull(
        initialized: (state) async {
          state.validate(_balances).fold(
            (e) {
              emit(state.copyWith(processingState: error(e)));
              emit(state.copyWith(processingState: none()));
            },
            (s) {
              _analyticsManager.swapTransactionCreated(
                from: state.input.symbol,
                to: state.output.symbol,
                amount: state.inputAmount.value,
              );
              emit(_State.success(s));
            },
          );
        },
      );

  Future<Iterable<Token>> _getOutputTokens(
    JupiterIndexedRouteMap routeMap,
    Token input,
  ) =>
      compute(
        _computeOutputTokens,
        _Output(map: routeMap, input: input, tokenList: _tokenList),
      );

  Future<void> _updateInput(
    FutureOr<void> Function(Initialized state) block,
  ) async =>
      state.mapOrNull(
        initialized: (state) async {
          await block(state);
          add(const CreateSwapEvent.outputInvalidated());
        },
      );
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

extension on Iterable<Token> {
  List<Token> sortedByName() => sorted((a, b) => a.name.compareTo(b.name));
}

extension on Token {
  Token get forJupiter => this == Token.sol ? Token.wrappedSol : this;
}

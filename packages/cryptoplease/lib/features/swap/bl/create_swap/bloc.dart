import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/analytics/analytics_manager.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/features/swap/bl/balances.dart';
import 'package:cryptoplease/features/swap/bl/swap_exception.dart';
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
    required AnalyticsManager analyticsManager,
  })  : _tokenList = tokenList,
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
    on<SlippageUpdated>(_onSlippageUpdated);
    on<InputUpdated>(_onInputUpdated);
    on<OutputUpdated>(_onOutputUpdated);
    on<RouteInvalidated>(
      _onRouteInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
    on<Submitted>(_onSubmitted);
  }

  final TokenList _tokenList;
  final JupiterAggregatorClient _jupiterClient;
  final Balances _balances;
  final AnalyticsManager _analyticsManager;

  CryptoAmount? calculateMaxAmount() => state.maybeMap(
        initialized: (state) => state.calculateMaxAmount(_balances),
        orElse: () => null,
      );

  Future<void> _onInit(Init event, _Emitter emit) async {
    final hasInitialized = state.maybeMap(none: F, success: F, orElse: T);
    if (hasInitialized) return;

    try {
      final routeMap = await _jupiterClient.getIndexedRouteMap();
      final mintKeys = routeMap.mintKeys;
      final jupiterTokens = mintKeys.map(_tokenList.findTokenByMint);

      final inputTokens = (await compute(
        _computeInputTokens,
        _Input(tokens: jupiterTokens, balances: _balances),
      ))
          // TODO: remove
          .toList()
        ..add(Token.usdcProd);

      final input = inputTokens.firstWhere(
        (token) => token == event.input,
        orElse: () => throw const SwapException.routeNotFound(),
      );

      final outputTokens = (await compute(
        _computeOutputTokens,
        _Output(map: routeMap, input: input, tokenList: _tokenList),
      ))
          // TODO: remove
          .toList()
        ..add(Token.usdcProd);

      final output = outputTokens.firstWhere(
        (token) => token == event.output,
        orElse: () => throw const SwapException.routeNotFound(),
      );

      final state = CreateSwapState.initialized(
        inputAmount: CryptoAmount(
          currency: CryptoCurrency(token: input),
          value: 0,
        ),
        outputAmount: CryptoAmount(
          currency: CryptoCurrency(token: output),
          value: 0,
        ),
        slippage: event.slippage,
      );

      emit(state);
    } on SwapException catch (e) {
      emit(CreateSwapState.failure(e));
    }
  }

  Future<void> _onRouteInvalidated(RouteInvalidated _, _Emitter emit) async =>
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

  Future<void> _onSlippageUpdated(SlippageUpdated event, _Emitter emit) async =>
      _updateInput((state) {
        emit(state.copyWith(slippage: event.slippage));
      });

  Future<void> _onInputUpdated(InputUpdated event, _Emitter emit) async =>
      _updateInput((state) {
        emit(
          state.copyWith(
            inputAmount: state.inputAmount.copyWithDecimal(event.decimal),
          ),
        );
      });

  Future<void> _onOutputUpdated(OutputUpdated event, _Emitter emit) async =>
      _updateInput((state) {
        emit(
          state.copyWith(
            outputAmount: state.outputAmount.copyWithDecimal(event.decimal),
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

  Future<void> _updateInput(
    FutureOr<void> Function(Initialized state) block,
  ) async =>
      state.mapOrNull(
        initialized: (state) async {
          await block(state);
          add(const CreateSwapEvent.routeInvalidated());
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

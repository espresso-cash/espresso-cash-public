import 'dart:async';

import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/analytics/analytics_manager.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/flow.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/swap/bl/repository.dart';
import 'package:cryptoplease/features/swap/bl/swap_exception.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = CreateSwapEvent;
typedef _State = CreateSwapState;
typedef _Emitter = Emitter<_State>;

enum SwapOperation { buy, sell }

class CreateSwapBloc extends Bloc<_Event, _State> {
  CreateSwapBloc({
    required Token input,
    required Token output,
    required Decimal initialSlippage,
    required SwapOperation swapOperation,
    required MyAccount myAccount,
    required Map<Token, Amount> balances,
    required JupiterRepository jupiterRepository,
    required AnalyticsManager analyticsManager,
  })  : _jupiterRepository = jupiterRepository,
        _myAccount = myAccount,
        _analyticsManager = analyticsManager,
        _balances = balances.lock.add(
          Token.wrappedSol,
          balances[Token.sol] ??
              Amount.zero(
                currency: const Currency.crypto(token: Token.wrappedSol),
              ),
        ),
        super(
          CreateSwapState(
            editingMode: swapOperation == SwapOperation.buy
                ? const SwapEditingMode.output()
                : const SwapEditingMode.input(),
            inputAmount: CryptoAmount(
              value: 0,
              currency: CryptoCurrency(token: input),
            ),
            outputAmount: CryptoAmount(
              value: 0,
              currency: CryptoCurrency(token: output),
            ),
            slippage: initialSlippage,
            flowState: const Flow.processing(),
          ),
        ) {
    on<Init>(_onInit);
    on<SlippageUpdated>(_onSlippageUpdated);
    on<EditingModeToggled>(_onEditingModeToggled);
    on<AmountUpdated>(_onAmountUpdated);
    on<RouteInvalidated>(
      _onRouteInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
    on<Submitted>(_onSubmitted);
  }

  final JupiterRepository _jupiterRepository;
  final AnalyticsManager _analyticsManager;
  final IMap<Token, Amount> _balances;
  final MyAccount _myAccount;

  bool isValidInput(Token token) => _balances.isPositive(token);

  Future<void> _onInit(Init _, _Emitter emit) async {
    try {
      final input = state.input;
      final output = state.output;
      final routeExists = await _jupiterRepository.routeExists(input, output);

      if (!routeExists) throw const SwapException.routeNotFound();

      emit(
        state.copyWith(
          flowState: const Flow.initial(),
        ),
      );
    } on SwapException catch (e) {
      emit(
        state.copyWith(
          flowState: Flow.failure(e),
        ),
      );
    }
  }

  Future<void> _onSlippageUpdated(SlippageUpdated event, _Emitter emit) async =>
      _updateRoute((state) {
        emit(state.copyWith(slippage: event.slippage));
      });

  Future<void> _onEditingModeToggled(
    EditingModeToggled _,
    _Emitter emit,
  ) async =>
      _updateRoute((state) {
        emit(
          state.copyWith(
            editingMode: state.editingMode.map(
              input: always(const SwapEditingMode.output()),
              output: always(const SwapEditingMode.input()),
            ),
          ),
        );
      });

  void _onAmountUpdated(AmountUpdated event, _Emitter emit) => _updateRoute(
        (state) => emit(
          state.editingMode.map(
            input: always(
              state.copyWith(
                inputAmount: state.inputAmount.copyWithDecimal(event.decimal),
              ),
            ),
            output: always(
              state.copyWith(
                outputAmount: state.outputAmount.copyWithDecimal(event.decimal),
              ),
            ),
          ),
        ),
      );

  Future<void> _onSubmitted(Submitted _, _Emitter emit) async {
    state.validate(_balances).fold(
      (e) {
        emit(state.copyWith(flowState: Flow.failure(e)));
        emit(state.copyWith(flowState: const Flow.initial()));
      },
      (s) {
        _analyticsManager.swapTransactionCreated(
          from: state.input.symbol,
          to: state.output.symbol,
          amount: state.inputAmount.value,
        );
        emit(
          state.copyWith(
            flowState: Flow.success(s),
          ),
        );
      },
    );
  }

  Future<void> _onRouteInvalidated(RouteInvalidated _, _Emitter emit) async {
    final amount = state.requestAmount;

    if (amount.value == 0) {
      emit(
        state.copyWith(
          bestRoute: null,
          inputAmount: state.inputAmount.copyWith(value: 0),
          outputAmount: state.outputAmount.copyWith(value: 0),
        ),
      );

      return;
    }

    emit(state.copyWith(flowState: const Flow.processing()));

    try {
      final routes = await _jupiterRepository.findRoutes(
        amount: amount,
        inputToken: state.input,
        outputToken: state.output,
        slippage: state.slippage,
        userPublickKey: _myAccount.address,
      );

      if (routes.isEmpty) throw const SwapException.routeNotFound();

      final bestRoute = state.editingMode.map(
        input: always(routes.first),
        output: always(routes.last),
      );

      final outputAmount = state.editingMode.map(
        input: always(state.outputAmount),
        output: always(
          state.outputAmount.copyWith(
            value: int.parse(bestRoute.outAmount),
          ),
        ),
      );

      final inputAmount = state.editingMode.map(
        input: always(state.inputAmount),
        output: always(
          state.inputAmount.copyWith(
            value: int.parse(bestRoute.inAmount),
          ),
        ),
      );

      emit(
        state.copyWith(
          bestRoute: bestRoute,
          outputAmount: outputAmount,
          inputAmount: inputAmount,
          flowState: const Flow.initial(),
        ),
      );
    } on SwapException catch (e) {
      emit(
        state.copyWith(
          flowState: Flow.failure(e),
          bestRoute: null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          flowState: Flow.failure(SwapException.other(e)),
          bestRoute: null,
        ),
      );
    }
  }

  Future<void> _updateRoute(
    FutureOr<void> Function(CreateSwapState state) block,
  ) async {
    await block(state);
    add(const CreateSwapEvent.routeInvalidated());
  }

  /// Calculates max swap amount for the selected token.
  ///
  /// It takes into account the fee, so for SOL the maximum possible amount is
  /// lesser than the user's balance.
  CryptoAmount calculateMaxAmount() {
    final balance = _balances.balanceFromToken(state.input);

    return state.input == Token.sol
        ? balance - state.fee as CryptoAmount
        : balance;
  }
}

extension BalanceExt on IMap<Token, Amount> {
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

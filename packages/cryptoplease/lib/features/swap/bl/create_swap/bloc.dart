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
      emit(state.processing());

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
      emit(state.error(e));
    }
  }

  Future<void> _onSlippageUpdated(SlippageUpdated event, _Emitter emit) async =>
      _updateRoute((state) {
        emit(state.copyWith(slippage: event.slippage));
      });

  Future<void> _onAmountUpdated(AmountUpdated event, _Emitter emit) async =>
      _updateRoute(
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

  Future<void> _onEditingModeToggled(
    EditingModeToggled _,
    _Emitter emit,
  ) async =>
      _updateRoute(
        (state) => emit(state.toggleEditingMode()),
      );

  Future<void> _onSubmitted(Submitted _, _Emitter emit) async {
    state.validate(_balances).fold(
      (e) {
        emit(state.copyWith(flowState: Flow.failure(e)));
        emit(state.copyWith(flowState: const Flow.initial()));
      },
      (r) {
        _analyticsManager.swapTransactionCreated(
          from: state.input.symbol,
          to: state.output.symbol,
          amount: state.inputAmount.value,
        );
        emit(
          state.copyWith(
            flowState: Flow.success(r),
          ),
        );
      },
    );
  }

  Future<void> _onRouteInvalidated(RouteInvalidated _, _Emitter emit) async {
    final amount = state.requestAmount;

    if (amount.value == 0) {
      emit(state.reset());

      return;
    }

    emit(state.processing());

    try {
      final routes = await _jupiterRepository.findRoutes(
        amount: amount,
        inputToken: state.input,
        outputToken: state.output,
        slippage: state.slippage,
        userPublickKey: _myAccount.address,
      );

      if (routes.isEmpty) throw const SwapException.routeNotFound();

      final bestRoute = routes.first;

      state.editingMode.when(
        input: always(
          emit(state.updateOutputFromRoute(bestRoute)),
        ),
        output: always(
          emit(state.updateInputFromRoute(bestRoute)),
        ),
      );
    } on SwapException catch (e) {
      emit(state.error(e));
    } on Exception catch (e) {
      emit(state.error(SwapException.other(e)));
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

extension on CreateSwapState {
  CreateSwapState processing() => copyWith(
        flowState: const Flow.processing(),
      );

  CreateSwapState error(SwapException e) => copyWith(
        bestRoute: null,
        flowState: Flow.failure(e),
      );

  CreateSwapState reset() => copyWith(
        bestRoute: null,
        inputAmount: inputAmount.copyWith(value: 0),
        outputAmount: outputAmount.copyWith(value: 0),
        flowState: const Flow.initial(),
      );

  CreateSwapState updateInputFromRoute(JupiterRoute bestRoute) => copyWith(
        bestRoute: bestRoute,
        flowState: const Flow.initial(),
        inputAmount: inputAmount.copyWith(
          value: int.parse(bestRoute.inAmount),
        ),
      );

  CreateSwapState updateOutputFromRoute(JupiterRoute bestRoute) => copyWith(
        bestRoute: bestRoute,
        flowState: const Flow.initial(),
        outputAmount: outputAmount.copyWith(
          value: int.parse(bestRoute.outAmount),
        ),
      );

  CreateSwapState toggleEditingMode() => copyWith(
        editingMode: editingMode.map(
          input: always(const SwapEditingMode.output()),
          output: always(const SwapEditingMode.input()),
        ),
      );
}

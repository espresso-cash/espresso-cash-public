import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/analytics/analytics_manager.dart';
import '../../../../core/currency.dart';
import '../../../../core/flow.dart';
import '../../../../core/tokens/token.dart';
import '../route.dart';
import 'route_repository.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = CreateSwapEvent;
typedef _State = CreateSwapState;
typedef _Emitter = Emitter<_State>;

@freezed
class SwapSetup with _$SwapSetup {
  const factory SwapSetup({
    required Token input,
    required Token output,
    required SwapEditingMode initialEditingMode,
    required Ed25519HDPublicKey userAccount,
  }) = _SwapSetup;
}

@injectable
class CreateSwapBloc extends Bloc<_Event, _State> {
  CreateSwapBloc({
    @factoryParam required SwapSetup setup,
    @factoryParam required Map<Token, Amount> balances,
    required RouteRepository routeRepository,
    required AnalyticsManager analyticsManager,
  })  : _jupiterRepository = routeRepository,
        _analyticsManager = analyticsManager,
        _userAccount = setup.userAccount,
        _balances = balances.lock.add(
          Token.wrappedSol,
          balances[Token.sol] ?? Token.wrappedSol.toZeroAmount(),
        ),
        super(
          CreateSwapState(
            editingMode: setup.initialEditingMode,
            inputAmount: setup.input.toZeroAmount(),
            outputAmount: setup.output.toZeroAmount(),
            slippage: Slippage.onePercent,
          ),
        ) {
    on<Init>(_onInit);
    on<SlippageUpdated>(_onSlippageUpdated);
    on<EditingModeToggled>(_onEditingModeToggled);
    on<AmountUpdated>(_onAmountUpdated);
    on<Submitted>(_onSubmitted);
    on<RouteInvalidated>(
      _onRouteInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
  }

  final RouteRepository _jupiterRepository;
  final AnalyticsManager _analyticsManager;
  final IMap<Token, Amount> _balances;
  final Ed25519HDPublicKey _userAccount;

  bool isValidInput(Token token) => _balances.isPositive(token);

  Future<void> _onInit(Init _, _Emitter emit) async {
    try {
      emit(state.processing());

      final input = state.input;
      final output = state.output;
      final routeExists = await _jupiterRepository.routeExists(input, output);

      if (!routeExists) throw const CreateSwapException.routeNotFound();

      emit(
        state.copyWith(
          flowState: const Flow.initial(),
        ),
      );
    } on CreateSwapException catch (e) {
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
      final bestRoute = await _jupiterRepository.findRoute(
        amount: amount,
        inputToken: state.input,
        outputToken: state.output,
        slippage: state.slippage,
        userPublickKey: _userAccount.toBase58(),
      );

      state.editingMode.when(
        input: () => emit(state.updateOutputFromRoute(bestRoute)),
        output: () => emit(state.updateInputFromRoute(bestRoute)),
      );
    } on CreateSwapException catch (e) {
      emit(state.error(e));
    } on Exception catch (e) {
      emit(state.error(CreateSwapException.other(e)));
    }
  }

  Future<void> _updateRoute(
    FutureOr<void> Function(CreateSwapState state) block,
  ) async {
    await block(state);
    add(const CreateSwapEvent.routeInvalidated());
  }

  CryptoAmount calculateMaxAmount() => _balances.balanceFromToken(state.input);
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

  CreateSwapState error(CreateSwapException e) => copyWith(
        bestRoute: null,
        flowState: Flow.failure(e),
      );

  CreateSwapState reset() => copyWith(
        bestRoute: null,
        inputAmount: inputAmount.copyWith(value: 0),
        outputAmount: outputAmount.copyWith(value: 0),
        flowState: const Flow.initial(),
        fetchedAt: null,
      );

  CreateSwapState updateInputFromRoute(SwapRoute bestRoute) => copyWith(
        bestRoute: bestRoute,
        flowState: const Flow.initial(),
        inputAmount: inputAmount.copyWith(value: bestRoute.inAmount),
        fetchedAt: DateTime.now(),
      );

  CreateSwapState updateOutputFromRoute(SwapRoute bestRoute) => copyWith(
        bestRoute: bestRoute,
        flowState: const Flow.initial(),
        outputAmount: outputAmount.copyWith(value: bestRoute.outAmount),
        fetchedAt: DateTime.now(),
      );

  CreateSwapState toggleEditingMode() => copyWith(
        editingMode: editingMode.map(
          input: always(const SwapEditingMode.output()),
          output: always(const SwapEditingMode.input()),
        ),
      );
}

extension on Token {
  CryptoAmount toZeroAmount() => CryptoAmount(
        value: 0,
        currency: CryptoCurrency(token: this),
      );
}

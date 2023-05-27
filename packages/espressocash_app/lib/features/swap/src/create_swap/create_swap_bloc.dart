import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/analytics/analytics_manager.dart';
import '../../../../../core/currency.dart';
import '../../../../../core/flow.dart';
import '../../../../../core/tokens/token.dart';
import '../../models/swap_seed.dart';
import '../route_repository.dart';
import '../swap_route.dart';

part 'create_swap_bloc.freezed.dart';
part 'create_swap_event.dart';
part 'create_swap_state.dart';

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
  })  : _routeRepository = routeRepository,
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
            flowState: const Flow.initial(),
          ),
        ) {
    on<SlippageUpdated>(_onSlippageUpdated);
    on<EditingModeToggled>(_onEditingModeToggled);
    on<AmountUpdated>(_onAmountUpdated);
    on<Submitted>(_onSubmitted);
    on<RouteInvalidated>(
      _onRouteInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
  }

  final RouteRepository _routeRepository;
  final AnalyticsManager _analyticsManager;
  final IMap<Token, Amount> _balances;
  final Ed25519HDPublicKey _userAccount;

  Future<void> _onSlippageUpdated(SlippageUpdated event, _Emitter emit) async {
    emit(state.copyWith(slippage: event.slippage));
    add(const CreateSwapEvent.routeInvalidated());
  }

  Future<void> _onAmountUpdated(AmountUpdated event, _Emitter emit) async {
    emit(
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
    );
    add(const CreateSwapEvent.routeInvalidated());
  }

  Future<void> _onEditingModeToggled(
    EditingModeToggled _,
    _Emitter emit,
  ) async {
    emit(state.toggleEditingMode());
    add(const CreateSwapEvent.routeInvalidated());
  }

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
      final bestRoute = await _routeRepository.findRoute(
        seed: SwapSeed(
          amount: amount,
          inputToken: state.input,
          outputToken: state.output,
          slippage: state.slippage,
        ),
        userPublicKey: _userAccount.toBase58(),
      );

      state.editingMode.when(
        input: () => emit(state.updateOutputFromRoute(bestRoute)),
        output: () => emit(state.updateInputFromRoute(bestRoute)),
      );
    } on CreateSwapException catch (e) {
      emit(state.error(e));
    } on Exception {
      emit(state.error(const CreateSwapException.routeNotFound()));
    }
  }
}

extension CreateSwapBlocExt on CreateSwapBloc {
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

    return CryptoAmount(
      value: value,
      cryptoCurrency: CryptoCurrency(token: token),
    );
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
        expiresAt: null,
      );

  CreateSwapState updateInputFromRoute(SwapRoute bestRoute) => copyWith(
        bestRoute: bestRoute,
        flowState: const Flow.initial(),
        inputAmount: inputAmount.copyWith(value: bestRoute.inAmount),
        expiresAt: DateTime.now().add(_routeDuration),
      );

  CreateSwapState updateOutputFromRoute(SwapRoute bestRoute) => copyWith(
        bestRoute: bestRoute,
        flowState: const Flow.initial(),
        outputAmount: outputAmount.copyWith(value: bestRoute.outAmount),
        expiresAt: DateTime.now().add(_routeDuration),
      );

  CreateSwapState toggleEditingMode() => copyWith(
        editingMode: editingMode.map(
          input: always(const SwapEditingMode.output()),
          output: always(const SwapEditingMode.input()),
        ),
        inputAmount: inputAmount.copyWithDecimal(outputAmount.decimal),
        outputAmount: outputAmount.copyWithDecimal(inputAmount.decimal),
      );
}

extension on Token {
  CryptoAmount toZeroAmount() => CryptoAmount(
        value: 0,
        cryptoCurrency: CryptoCurrency(token: this),
      );
}

const _routeDuration = Duration(seconds: 15);

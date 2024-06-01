import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';

import '../../../utils/flow.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../analytics/analytics_manager.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../data/route_repository.dart';
import '../models/swap_route.dart';
import '../models/swap_seed.dart';

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
  }) = _SwapSetup;
}

const _defaultInputToken = Token.sol;
const _defaultOutputToken = Token.usdc;

@injectable
class CreateSwapBloc extends Bloc<_Event, _State> {
  CreateSwapBloc({
    required RouteRepository routeRepository,
    required AnalyticsManager analyticsManager,
    // required BalancesRepository balancesRepository, //TODO add when merged
    required ECWallet wallet,
  })  : _routeRepository = routeRepository,
        _analyticsManager = analyticsManager,
        _userAccount = wallet.publicKey,
        _balances = IMap.fromEntries(const {}),
        // _balances = balancesRepository.readAll().add(
        //       Token.wrappedSol,
        //       balancesRepository.read(Token.sol).copyWith(
        //             cryptoCurrency:
        //                 const CryptoCurrency(token: Token.wrappedSol),
        //           ),
        //     ),
        super(
          CreateSwapState(
            inputAmount: _defaultInputToken.toZeroAmount(),
            outputAmount: _defaultOutputToken.toZeroAmount(),
            slippage: Slippage.onePercent,
            flowState: const Flow.initial(),
          ),
        ) {
    on<InputTokenUpdated>(_onInputTokenUpdated);
    on<OutputTokenUpdated>(_onOutputTokenUpdated);
    on<Swapped>(_onSwapped);
    on<SlippageUpdated>(_onSlippageUpdated);
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

  // void _onInitialize(Initialize event, _Emitter emit) {
  //   emit(
  //     state.copyWith(
  //       inputAmount: event.setup.input.toZeroAmount(),
  //       outputAmount: event.setup.output.toZeroAmount(),
  //     ),
  //   );
  //   add(const CreateSwapEvent.routeInvalidated());
  // }

  void _onInputTokenUpdated(InputTokenUpdated event, _Emitter emit) {
    emit(state.copyWith(inputAmount: event.token.toZeroAmount()));
    add(const CreateSwapEvent.routeInvalidated());
  }

  void _onOutputTokenUpdated(OutputTokenUpdated event, _Emitter emit) {
    emit(state.copyWith(outputAmount: event.token.toZeroAmount()));
    add(const CreateSwapEvent.routeInvalidated());
  }

  void _onSwapped(Swapped _, _Emitter emit) {
    emit(
      state.copyWith(
        inputAmount: state.outputAmount,
        outputAmount: state.inputAmount,
      ),
    );
    add(const CreateSwapEvent.routeInvalidated());
  }

  void _onSlippageUpdated(SlippageUpdated event, _Emitter emit) {
    emit(state.copyWith(slippage: event.slippage));
    add(const CreateSwapEvent.routeInvalidated());
  }

  void _onAmountUpdated(AmountUpdated event, _Emitter emit) {
    emit(
      state.copyWith(
        inputAmount: state.inputAmount.copyWithDecimal(event.decimal),
      ),
    );
    add(const CreateSwapEvent.routeInvalidated());
  }

  // void _onEditingModeToggled(
  //   EditingModeToggled _,
  //   _Emitter emit,
  // ) {
  //   emit(state.toggleEditingMode());
  //   add(const CreateSwapEvent.routeInvalidated());
  // }

  void _onSubmitted(Submitted _, _Emitter emit) {
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

    final input = state.input;
    final output = state.output;

    emit(state.processing());

    try {
      final bestRoute = await _routeRepository.findRoute(
        seed: SwapSeed(
          amount: amount,
          inputToken: input,
          outputToken: output,
          slippage: state.slippage,
        ),
        userPublicKey: _userAccount.toBase58(),
      );

      emit(state.updateOutputFromRoute(bestRoute));

      // state.editingMode.when(
      //   input: () => ,
      //   output: () => emit(state.updateInputFromRoute(bestRoute)),
      // );
    } on CreateSwapException catch (error) {
      emit(state.error(error));
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

  // CreateSwapState toggleEditingMode() => copyWith(
  //       editingMode: editingMode.map(
  //         input: always(const SwapEditingMode.output()),
  //         output: always(const SwapEditingMode.input()),
  //       ),
  //       inputAmount:
  //           inputAmount?.copyWithDecimal(outputAmount?.decimal ?? Decimal.zero),
  //       outputAmount:
  //           outputAmount?.copyWithDecimal(inputAmount?.decimal ?? Decimal.zero),
  //     );
}

extension on Token {
  CryptoAmount toZeroAmount() => CryptoAmount(
        value: 0,
        cryptoCurrency: CryptoCurrency(token: this),
      );
}

const _routeDuration = Duration(seconds: 15);

import 'dart:async';

import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/swap/bl/balances.dart';
import 'package:cryptoplease/features/swap/bl/repository.dart';
import 'package:cryptoplease/features/swap/bl/swap_exception.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';
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
    required JupiterRepository jupiterRepository,
    required Token input,
    required Token output,
    required Decimal initialSlippage,
  })  : _jupiterRepository = jupiterRepository,
        super(
          CreateSwapState(
            inputAmount: CryptoAmount(
              value: 0,
              currency: CryptoCurrency(token: input),
            ),
            outputAmount: CryptoAmount(
              value: 0,
              currency: CryptoCurrency(token: output),
            ),
            slippage: initialSlippage,
            processingState: const ProcessingState.processing(),
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

  bool isValidInput(Token token, Balances balances) =>
      balances.isPositive(token);

  Future<void> _onInit(Init _, _Emitter emit) async {
    try {
      final input = state.input;
      final output = state.output;
      final routeExists = await _jupiterRepository.routeExists(input, output);

      if (!routeExists) throw const SwapException.routeNotFound();

      emit(
        state.copyWith(
          processingState: const ProcessingState.none(),
        ),
      );
    } on SwapException catch (e) {
      emit(state.copyWith(processingState: ProcessingState.error(e)));
    }
  }

  Future<void> _onRouteInvalidated(RouteInvalidated _, _Emitter emit) async {
    print('kkkk');
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

    emit(state.copyWith(processingState: processing()));

    try {
      final bestRoute = await _jupiterRepository.bestRoute(
        amount,
        state.input,
        state.output,
        state.slippage,
        state.swapMode,
      );

      if (state.editingMode == SwapEditingMode.input) {
        emit(
          state.copyWith(
            bestRoute: bestRoute,
            processingState: none(),
            outputAmount: state.outputAmount.copyWith(
              value: bestRoute.outAmount,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            bestRoute: bestRoute,
            processingState: none(),
            inputAmount: state.inputAmount.copyWith(
              value: bestRoute.inAmount,
            ),
          ),
        );
      }
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
            editingMode: state.editingMode == SwapEditingMode.input
                ? SwapEditingMode.output
                : SwapEditingMode.input,
          ),
        );
      });

  Future<void> _onAmountUpdated(AmountUpdated event, _Emitter emit) async =>
      _updateRoute((state) {
        final CreateSwapState newState;
        if (state.editingMode == SwapEditingMode.input) {
          newState = state.copyWith(
            inputAmount: state.inputAmount.copyWithDecimal(event.decimal),
          );
        } else {
          newState = state.copyWith(
            outputAmount: state.outputAmount.copyWithDecimal(event.decimal),
          );
        }

        emit(newState);
      });

  Future<void> _onSubmitted(Submitted _, _Emitter emit) async {
    // state.validate(_balances).fold(
    //   (e) {
    //     emit(state.copyWith(processingState: error(e)));
    //     emit(state.copyWith(processingState: none()));
    //   },
    //   (s) {
    //     _analyticsManager.swapTransactionCreated(
    //       from: state.input.symbol,
    //       to: state.output.symbol,
    //       amount: state.inputAmount.value,
    //     );
    //     emit(_State.success(s));
    //   },
    // );
  }

  Future<void> _updateRoute(
    FutureOr<void> Function(CreateSwapState state) block,
  ) async {
    await block(state);
    add(const CreateSwapEvent.routeInvalidated());
  }
}

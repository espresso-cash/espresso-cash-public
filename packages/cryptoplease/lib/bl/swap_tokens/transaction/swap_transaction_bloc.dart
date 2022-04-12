import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/flow.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';

part 'swap_transaction_bloc.freezed.dart';
part 'swap_transaction_event.dart';
part 'swap_transaction_state.dart';

typedef _Event = SwapTransactionEvent;
typedef _State = SwapTransactionState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class SwapTransactionBloc
    extends Bloc<SwapTransactionEvent, SwapTransactionState> {
  SwapTransactionBloc({
    required JupiterAggregatorClient jupiterAggregatorClient,
    required MyAccount myAccount,
  })  : _jupiterClient = jupiterAggregatorClient,
        _myAccount = myAccount,
        super(
          const SwapTransactionState(),
        ) {
    on<_Event>(_eventHandler, transformer: sequential());
  }

  final JupiterAggregatorClient _jupiterClient;
  final MyAccount _myAccount;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        swap: (e) => _onSwap(e, emit),
      );

  Future<void> _onSwap(SwapEvent swapEvent, _Emitter emit) async {
    try {
      emit(state.copyWith(flow: const Flow.processing()));

      final routes = await _jupiterClient.getQuote(
        amount: swapEvent.amount.value,
        inputMint: swapEvent.inputToken.address,
        outputMint: swapEvent.outputToken.address,
        slippage: swapEvent.slippage,
      );

      if (routes.isEmpty) {
        throw NoRouteAvailable();
      }

      final route = routes.first;
      final publicKey = _myAccount.publicKey.toBase58();

      final transaction = await _jupiterClient.getSwapTransactions(
        route: route,
        userPublicKey: publicKey,
      );

      emit(
        state.copyWith(
          flow: Flow.success(transaction.swapTransaction),
        ),
      );
    } on Exception catch (exception) {
      emit(
        state.copyWith(
          flow: Flow.failure(exception),
        ),
      );
    }
  }
}

class NoRouteAvailable implements Exception {}

import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_pay_bloc.freezed.dart';
part 'request_pay_event.dart';
part 'request_pay_state.dart';

typedef _Event = RequestPayEvent;
typedef _State = RequestPayState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class RequestPayBloc extends Bloc<_Event, _State> {
  RequestPayBloc()
      : super(
          const RequestPayState(
            token: Token.usdc,
            amount: CryptoAmount(
              value: 0,
              currency: CryptoCurrency(token: Token.usdc),
            ),
            availableTokens: [Token.usdc, Token.usdt],
          ),
        ) {
    on<_Event>(_eventHandler);
  }

  _EventHandler get _eventHandler => (event, emit) => event.map(
        tokenUpdated: (event) => _onTokenUpdated(event, emit),
        amountUpdated: (event) => _onAmountUpdated(event, emit),
      );

  void _onTokenUpdated(_TokenUpdated event, _Emitter emit) {
    emit(
      state.copyWith(
        token: event.token,
        amount: state.amount.copyWith(
          currency: CryptoCurrency(token: event.token),
        ),
      ),
    );
  }

  void _onAmountUpdated(_AmountUpdated event, _Emitter emit) {
    emit(
      state.copyWith(
        amount: state.amount.copyWithDecimal(event.amount),
      ),
    );
  }
}

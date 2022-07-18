import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
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
  RequestPayBloc({
    required TokenList tokenList,
  })  : _tokenList = tokenList,
        super(
          const RequestPayState(
            processingState: ProcessingState.processing(),
            token: Token.sol,
            amount: CryptoAmount(
              value: 0,
              currency: CryptoCurrency(token: Token.sol),
            ),
            availableTokens: [],
          ),
        ) {
    on<_Event>(_eventHandler);
  }

  final TokenList _tokenList;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        initialized: (_) => _onInitialized(emit),
        tokenUpdated: (event) => _onTokenUpdated(event, emit),
        amountUpdated: (event) => _onAmountUpdated(event, emit),
      );

  void _onInitialized(_Emitter emit) {
    final symbols = ['USDC', 'USDT'];
    final tokens = _tokenList.tokens.where(
      (token) => symbols.contains(token.symbol) && token.isStablecoin,
    );

    if (tokens.isEmpty) {
      emit(
        state.copyWith(
          processingState: ProcessingState.error(
            _RequestPayException('Failed to fetch stable coins'),
          ),
        ),
      );

      return;
    }

    final initialToken = tokens.first;

    emit(
      state.copyWith(
        token: initialToken,
        availableTokens: tokens,
        amount: state.amount.copyWith(
          currency: CryptoCurrency(token: initialToken),
        ),
        processingState: const ProcessingState.none(),
      ),
    );
  }

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

class _RequestPayException implements Exception {
  _RequestPayException(this.message);

  final String message;

  @override
  String toString() => message;
}

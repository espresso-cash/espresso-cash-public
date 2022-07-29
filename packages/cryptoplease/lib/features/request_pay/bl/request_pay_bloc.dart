import 'package:collection/collection.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
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
    required Map<Token, Amount> balances,
  })  : _tokenList = tokenList,
        _balances = balances,
        super(
          const RequestPayState(
            processingState: ProcessingState.processing(),
            amount: CryptoAmount(
              value: 0,
              currency: CryptoCurrency(token: Token.sol),
            ),
          ),
        ) {
    on<_Event>(_eventHandler);
  }

  final TokenList _tokenList;
  final Map<Token, Amount> _balances;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        initialized: (_) => _onInitialized(emit),
        amountUpdated: (event) => _onAmountUpdated(event, emit),
      );

  void _onInitialized(_Emitter emit) {
    final usdcToken = _tokenList.tokens.firstWhereOrNull(
      (token) => token.symbol == 'USDC' && token.isStablecoin,
    );

    if (usdcToken == null) {
      emit(
        state.copyWith(
          processingState: ProcessingState.error(
            _RequestPayException('Failed to fetch stable coins'),
          ),
        ),
      );

      return;
    }

    emit(
      state.copyWith(
        amount: state.amount.copyWith(
          currency: CryptoCurrency(token: usdcToken),
        ),
        processingState: const ProcessingState.none(),
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

  Either<ValidationError, void> validate() {
    final token = state.amount.token;
    final userBalance = _balances[token] ??
        Amount.zero(currency: Currency.crypto(token: token));

    if (userBalance < state.amount) {
      return Either.left(
        ValidationError.insufficientFunds(
          balance: userBalance,
          currentAmount: state.amount,
        ),
      );
    }

    var feeBalance =
        _balances[Token.sol] ?? Amount.zero(currency: Currency.sol);
    if (token == Token.sol) {
      feeBalance -= state.amount;
    }

    if (feeBalance < state.fee) {
      return Either.left(ValidationError.insufficientFee(state.fee));
    }

    return const Either.right(null);
  }
}

class _RequestPayException implements Exception {
  _RequestPayException(this.message);

  final String message;

  @override
  String toString() => message;
}

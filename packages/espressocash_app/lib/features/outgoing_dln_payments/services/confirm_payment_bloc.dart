import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/flow.dart';
import '../../balances/data/balances_repository.dart';
import '../../tokens/token.dart';
import '../data/quote_repository.dart';
import '../models/dln_payment.dart';
import '../models/payment_quote.dart';

part 'confirm_payment_bloc.freezed.dart';

typedef _Event = ConfirmPaymentEvent;
typedef _State = ConfirmPaymentState;
typedef _Emitter = Emitter<_State>;

@injectable
class ConfirmPaymentBloc extends Bloc<_Event, _State> {
  ConfirmPaymentBloc({
    @factoryParam required this.payment,
    required QuoteRepository quoteRepository,
    required BalancesRepository balancesRepository,
  })  : _quoteRepository = quoteRepository,
        _usdcBalance = balancesRepository.readAll()[Token.usdc] ??
            const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc),
        super(
          ConfirmPaymentState(flowState: const Flow.initial()),
        ) {
    on<Confirmed>(_onConfirmed);
    on<Invalidated>(
      _onInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
  }

  final QuoteRepository _quoteRepository;
  final CryptoAmount _usdcBalance;
  final DlnPayment payment;

  void _onConfirmed(Confirmed _, _Emitter emit) {
    state.validate(_usdcBalance).fold(
      (e) {
        emit(state.copyWith(flowState: Flow.failure(e)));
        emit(state.copyWith(flowState: const Flow.initial()));
      },
      (r) {
        emit(state.copyWith(flowState: Flow.success(r)));
      },
    );
  }

  Future<void> _onInvalidated(Invalidated _, _Emitter emit) async {
    emit(state.processing());

    try {
      final quote = await _quoteRepository.getQuote(
        amount: payment.inputAmount,
        receiverAddress: payment.receiverAddress,
        receiverBlockchain: payment.receiverBlockchain,
      );

      emit(state.update(quote));
    } on CreateOrderException catch (error) {
      emit(state.error(error));
    } on Exception {
      emit(state.error(const CreateOrderException.quoteNotFound()));
    }
  }
}

extension on ConfirmPaymentState {
  ConfirmPaymentState processing() => copyWith(
        flowState: const Flow.processing(),
      );

  ConfirmPaymentState error(CreateOrderException e) => copyWith(
        quote: null,
        flowState: Flow.failure(e),
      );

  ConfirmPaymentState update(PaymentQuote quote) => copyWith(
        quote: quote,
        flowState: const Flow.initial(),
        expiresAt: DateTime.now().add(_quoteDuration),
      );
}

@freezed
class ConfirmPaymentEvent with _$ConfirmPaymentEvent {
  const factory ConfirmPaymentEvent.confirmed() = Confirmed;

  const factory ConfirmPaymentEvent.invalidated() = Invalidated;
}

@freezed
class ConfirmPaymentState with _$ConfirmPaymentState {
  factory ConfirmPaymentState({
    PaymentQuote? quote,
    DateTime? expiresAt,
    @Default(Flow<CreateOrderException, PaymentQuote>.initial())
    Flow<CreateOrderException, PaymentQuote> flowState,
  }) = Initialized;
}

extension ConfirmPaymentExt on ConfirmPaymentState {
  CryptoAmount get fee =>
      quote?.fee ?? const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);

  CryptoAmount get inputAmount =>
      quote?.inputAmount ??
      const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);

  CryptoAmount get receiverAmount =>
      quote?.receiverAmount ??
      const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);

  Either<CreateOrderException, PaymentQuote> validate(
    CryptoAmount usdcBalance,
  ) {
    final totalAmount = inputAmount + fee;

    if (usdcBalance < totalAmount) {
      return Either.left(
        CreateOrderException.insufficientBalance(
          balance: usdcBalance,
          amount: totalAmount as CryptoAmount,
        ),
      );
    }

    final route = quote;

    return route == null
        ? const Either.left(CreateOrderException.quoteNotFound())
        : Either.right(route);
  }
}

@freezed
class CreateOrderException with _$CreateOrderException implements Exception {
  const factory CreateOrderException.other(Exception e) = OtherException;

  const factory CreateOrderException.quoteNotFound() = QuoteNotFound;

  const factory CreateOrderException.insufficientBalance({
    required CryptoAmount balance,
    required CryptoAmount amount,
  }) = InsufficientBalance;
}

const _quoteDuration = Duration(seconds: 20);

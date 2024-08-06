import 'dart:async';

import 'package:dfunc/dfunc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';
import '../../../utils/flow.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../balances/data/repository.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../create_dln_payment.dart';
import '../models/dln_payment.dart';
import '../models/payment_quote.dart';

part 'confirm_payment_bloc.freezed.dart';

typedef _Event = ConfirmPaymentEvent;
typedef _State = ConfirmPaymentState;
typedef _Emitter = Emitter<_State>;

@injectable
class ConfirmPaymentBloc extends Bloc<_Event, _State> {
  ConfirmPaymentBloc({
    required CreateDlnPayment createDlnPayment,
    required TokenBalancesRepository balancesRepository,
    required ECWallet account,
  })  : _createDlnPayment = createDlnPayment,
        _balancesRepository = balancesRepository,
        _account = account,
        super(ConfirmPaymentState(flowState: const Flow.initial())) {
    on<Init>(_onInit);
    on<Confirmed>(_onConfirmed);
    on<Invalidated>(
      _onInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
  }

  final CreateDlnPayment _createDlnPayment;
  final TokenBalancesRepository _balancesRepository;
  final ECWallet _account;

  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(_quoteDuration, () => add(const Invalidated()));
  }

  void _onInit(Init event, _Emitter emit) {
    emit(
      ConfirmPaymentState(
        payment: event.payment,
        flowState: const Flow.initial(),
      ),
    );

    add(const Invalidated());
  }

  Future<void> _onConfirmed(Confirmed _, _Emitter emit) async {
    final usdcBalance = await _balancesRepository.read(Token.usdc);
    state.validate(usdcBalance).fold(
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

    final payment = state.payment;

    if (payment == null) {
      emit(state.error(const CreateOrderException.quoteNotFound()));

      return;
    }

    try {
      final createDlnPayment = await _createDlnPayment(
        amount: payment.inputAmount.value,
        senderAddress: _account.publicKey.toBase58(),
        receiverAddress: payment.receiverAddress,
        receiverChain: payment.receiverBlockchain.name,
        commitment: Commitment.confirmed,
      );

      final quote = PaymentQuote(
        payment: DlnPayment(
          inputAmount: payment.inputAmount,
          receiverAddress: payment.receiverAddress,
          receiverBlockchain: payment.receiverBlockchain,
        ),
        receiverAmount: CryptoAmount(
          cryptoCurrency: Currency.usdc,
          value: createDlnPayment.receiverAmount,
        ),
        inputAmount: payment.inputAmount,
        fee: CryptoAmount(
          cryptoCurrency: Currency.usdc,
          value: createDlnPayment.fee,
        ),
        encodedTx: createDlnPayment.transaction.encode(),
      );

      _startTimer();

      emit(state.update(quote));
    } on CreateOrderException catch (error) {
      emit(state.error(error));
    } on Exception {
      emit(state.error(const CreateOrderException.quoteNotFound()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();

    return super.close();
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
      );
}

@Freezed(map: FreezedMapOptions.none, when: FreezedWhenOptions.none)
sealed class ConfirmPaymentEvent with _$ConfirmPaymentEvent {
  const factory ConfirmPaymentEvent.init(DlnPayment payment) = Init;

  const factory ConfirmPaymentEvent.confirmed() = Confirmed;

  const factory ConfirmPaymentEvent.invalidated() = Invalidated;
}

@freezed
class ConfirmPaymentState with _$ConfirmPaymentState {
  factory ConfirmPaymentState({
    DlnPayment? payment,
    PaymentQuote? quote,
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

  @useResult
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

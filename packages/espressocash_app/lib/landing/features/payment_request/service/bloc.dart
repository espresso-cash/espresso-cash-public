import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/flow.dart';
import '../../../../features/blockchain/models/blockchain.dart';
import '../data/repository.dart';
import '../models/incoming_quote.dart';
import '../models/request_model.dart';

part 'bloc.freezed.dart';

typedef _Event = IncomingPaymentEvent;
typedef _State = IncomingPaymentState;
typedef _Emitter = Emitter<_State>;

typedef Input = (Blockchain, String);

@injectable //TODO UPDATE DI
class IncomingPaymentBloc extends Bloc<_Event, _State> {
  IncomingPaymentBloc({
    required IncomingQuoteRepository quoteRepository,
  })  : _quoteRepository = quoteRepository,
        super(IncomingPaymentState(flowState: const Flow.initial())) {
    on<Init>(_onInit);
    on<Confirmed>(_onConfirmed);
    on<Invalidated>(
      _onInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
  }

  final IncomingQuoteRepository _quoteRepository;

  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(_quoteDuration, () => add(const Invalidated()));
  }

  void _onInit(Init event, _Emitter emit) {
    emit(
      IncomingPaymentState(
        request: event.request,
        flowState: const Flow.initial(),
      ),
    );

    add(const Invalidated());
  }

  void _onConfirmed(Confirmed _, _Emitter emit) {
    // emit(state.copyWith(flowState: const Flow.success(null))); //TODO
  }

  Future<void> _onInvalidated(Invalidated _, _Emitter emit) async {
    emit(state.processing());

    final request = state.request;

    if (request == null) {
      emit(state.error(const PaymentException.quoteNotFound()));

      return;
    }

    try {
      final quote = await _quoteRepository.getQuote(
        amount: request.requestAmount,
        receiverAddress: request.receiverAddress,
        senderAddress: request.senderAddress,
        senderBlockchain: request.senderBlockchain,
        solanaReferenceAddress: request.solanaReferenceAddress,
      );

      _startTimer();

      emit(state.update(quote));
    } on PaymentException catch (error) {
      emit(state.error(error));
    } on Exception {
      emit(state.error(const PaymentException.quoteNotFound()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();

    return super.close();
  }
}

extension on IncomingPaymentState {
  IncomingPaymentState processing() => copyWith(
        flowState: const Flow.processing(),
      );

  IncomingPaymentState error(PaymentException e) => copyWith(
        quote: null,
        flowState: Flow.failure(e),
      );

  IncomingPaymentState update(IncomingPaymentQuote quote) => copyWith(
        quote: quote,
        flowState: const Flow.initial(),
      );
}

@Freezed(map: FreezedMapOptions.none, when: FreezedWhenOptions.none)
sealed class IncomingPaymentEvent with _$IncomingPaymentEvent {
  const factory IncomingPaymentEvent.init(IncomingPaymentRequest request) =
      Init;

  const factory IncomingPaymentEvent.confirmed() = Confirmed;

  const factory IncomingPaymentEvent.invalidated() = Invalidated;
}

@freezed
class IncomingPaymentState with _$IncomingPaymentState {
  factory IncomingPaymentState({
    IncomingPaymentRequest? request,
    IncomingPaymentQuote? quote,
    @Default(Flow<PaymentException, IncomingPaymentQuote>.initial())
    Flow<PaymentException, IncomingPaymentQuote> flowState,
  }) = Initialized;
}

extension IncomingPaymentStateExt on IncomingPaymentState {
  CryptoAmount get fee =>
      quote?.fee ?? const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);

  CryptoAmount get inputAmount =>
      quote?.inputAmount ??
      const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);

  CryptoAmount get receiverAmount =>
      quote?.receiverAmount ??
      const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);
}

@freezed
class PaymentException with _$PaymentException implements Exception {
  const factory PaymentException.other(Exception e) = OtherException;

  const factory PaymentException.quoteNotFound() = QuoteNotFound;
}

const _quoteDuration = Duration(seconds: 25);

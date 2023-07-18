import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';
import 'package:uuid/uuid.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/flow.dart';
import '../../../core/tokens/token.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/amount_ext.dart';
import '../data/repository.dart';
import '../models/payment_request.dart';

part 'create_payment_request_bloc.freezed.dart';

@freezed
class CreatePaymentRequestEvent with _$CreatePaymentRequestEvent {
  const factory CreatePaymentRequestEvent.labelUpdated(String value) =
      LabelUpdated;

  const factory CreatePaymentRequestEvent.tokenAmountUpdated(
    Decimal amount,
  ) = TokenAmountUpdated;

  const factory CreatePaymentRequestEvent.fiatAmountUpdated(
    Decimal amount,
  ) = FiatAmountUpdated;

  const factory CreatePaymentRequestEvent.submitted({
    required Ed25519HDPublicKey recipient,
  }) = Submitted;
}

@freezed
class CreatePaymentRequestState with _$CreatePaymentRequestState {
  const factory CreatePaymentRequestState({
    @Default('') String label,
    required CryptoAmount tokenAmount,
    required FiatAmount fiatAmount,
    required Flow<Exception, PaymentRequest> flow,
  }) = _CreatePaymentRequestState;

  const CreatePaymentRequestState._();

  Token get token => tokenAmount.cryptoCurrency.token;
}

typedef _Event = CreatePaymentRequestEvent;
typedef _State = CreatePaymentRequestState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class CreatePaymentRequestBloc extends Bloc<_Event, _State> {
  CreatePaymentRequestBloc({
    required PaymentRequestRepository repository,
    required ConversionRatesRepository conversionRatesRepository,
  })  : _repository = repository,
        _conversionRatesRepository = conversionRatesRepository,
        super(
          // ignore: prefer_const_constructors, analyzer complains about flow
          CreatePaymentRequestState(
            tokenAmount: const CryptoAmount(
              value: 0,
              cryptoCurrency: Currency.usdc,
            ),
            fiatAmount:
                const FiatAmount(value: 0, fiatCurrency: defaultFiatCurrency),
            flow: const Flow<Exception, PaymentRequest>.initial(),
          ),
        ) {
    on<_Event>(_eventHandler);
  }

  final PaymentRequestRepository _repository;
  final ConversionRatesRepository _conversionRatesRepository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        labelUpdated: (event) => _onLabelUpdated(event, emit),
        tokenAmountUpdated: (event) => _onAmountUpdated(event, emit),
        fiatAmountUpdated: (event) => _onFiatAmountUpdated(event, emit),
        submitted: (event) => _onSubmitted(event, emit),
      );

  FiatAmount _toFiatAmount(CryptoAmount tokenAmount) =>
      tokenAmount.toFiatAmount(
        state.fiatAmount.fiatCurrency,
        ratesRepository: _conversionRatesRepository,
      ) ??
      state.fiatAmount.copyWith(value: 0);

  CryptoAmount? _toTokenAmount(FiatAmount fiatAmount) =>
      fiatAmount.toTokenAmount(
        state.token,
        ratesRepository: _conversionRatesRepository,
      );

  Future<void> _onLabelUpdated(
    LabelUpdated event,
    _Emitter emit,
  ) async {
    emit(state.copyWith(label: event.value));
  }

  Future<void> _onAmountUpdated(
    TokenAmountUpdated event,
    _Emitter emit,
  ) async {
    if (!state.flow.isInitial) return;

    final tokenAmount = state.tokenAmount.copyWithDecimal(event.amount);
    final fiatAmount = _toFiatAmount(tokenAmount);

    emit(state.copyWith(tokenAmount: tokenAmount, fiatAmount: fiatAmount));
  }

  Future<void> _onFiatAmountUpdated(
    FiatAmountUpdated event,
    _Emitter emit,
  ) async {
    if (!state.flow.isInitial) return;

    final fiatAmount = state.fiatAmount.copyWithDecimal(event.amount);
    final tokenAmount = _toTokenAmount(fiatAmount);

    if (tokenAmount == null) return;

    emit(state.copyWith(tokenAmount: tokenAmount, fiatAmount: fiatAmount));
  }

  Future<void> _onSubmitted(Submitted event, _Emitter emit) async {
    if (state.label.isEmpty) throw StateError('Label is empty.');

    emit(state.copyWith(flow: const Flow.processing()));

    final reference = (await Ed25519HDKeyPair.random()).publicKey;
    final Token token = state.tokenAmount.token;
    final Decimal amount = state.tokenAmount.decimal;

    final request = SolanaPayRequest(
      recipient: event.recipient,
      amount: amount,
      splToken: token == Token.sol ? null : token.publicKey,
      reference: [reference],
    );

    final paymentRequest = PaymentRequest(
      id: const Uuid().v4(),
      created: DateTime.now(),
      label: state.label,
      payRequest: request,
      dynamicLink: request.toUniversalLink().toString(),
      state: const PaymentRequestState.initial(),
    );
    await _repository.save(paymentRequest);
    emit(state.copyWith(flow: Flow.success(paymentRequest)));
  }
}

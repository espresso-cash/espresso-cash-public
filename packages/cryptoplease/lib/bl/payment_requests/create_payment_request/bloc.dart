import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/flow.dart';
import 'package:cryptoplease/bl/payment_requests/payment_request.dart';
import 'package:cryptoplease/bl/payment_requests/repository.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';
import 'package:uuid/uuid.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = CreatePaymentRequestEvent;
typedef _State = CreatePaymentRequestState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class CreatePaymentRequestBloc extends Bloc<_Event, _State> {
  CreatePaymentRequestBloc({
    required FiatCurrency userCurrency,
    required Map<Token, Amount> balances,
    Token? initialToken,
    required PaymentRequestRepository repository,
    required ConversionRatesRepository conversionRatesRepository,
  })  : _repository = repository,
        _conversionRatesRepository = conversionRatesRepository,
        super(
          CreatePaymentRequestState(
            availableTokens: initialToken == null
                ? IList(balances.keys)
                : IList([initialToken]),
            tokenAmount: initialToken == null
                ? const CryptoAmount(value: 0, currency: Currency.sol)
                : CryptoAmount(
                    value: 0,
                    currency: CryptoCurrency(token: initialToken),
                  ),
            fiatAmount: FiatAmount(value: 0, currency: userCurrency),
          ),
        ) {
    on<_Event>(_eventHandler);
  }

  final PaymentRequestRepository _repository;
  final ConversionRatesRepository _conversionRatesRepository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        payerNameUpdated: (event) => _onPayerNameUpdated(event, emit),
        tokenAmountUpdated: (event) => _onAmountUpdated(event, emit),
        fiatAmountUpdated: (event) => _onFiatAmountUpdated(event, emit),
        tokenUpdated: (event) => _onTokenUpdated(event, emit),
        submitted: (event) => _onSubmitted(event, emit),
      );

  FiatAmount _toFiatAmount(CryptoAmount tokenAmount) =>
      tokenAmount.toFiatAmount(
        state.fiatAmount.currency,
        ratesRepository: _conversionRatesRepository,
      ) ??
      state.fiatAmount.copyWith(value: 0);

  CryptoAmount? _toTokenAmount(FiatAmount fiatAmount) =>
      fiatAmount.toTokenAmount(
        state.token,
        ratesRepository: _conversionRatesRepository,
      );

  Future<void> _onPayerNameUpdated(
    PayerNameUpdated event,
    _Emitter emit,
  ) async {
    emit(state.copyWith(payerName: event.value));
  }

  Future<void> _onAmountUpdated(
    TokenAmountUpdated event,
    _Emitter emit,
  ) async {
    if (!state.flow.isInitial()) return;

    final tokenAmount = state.tokenAmount.copyWithDecimal(event.amount);
    final fiatAmount = _toFiatAmount(tokenAmount);

    emit(state.copyWith(tokenAmount: tokenAmount, fiatAmount: fiatAmount));
  }

  Future<void> _onFiatAmountUpdated(
    FiatAmountUpdated event,
    _Emitter emit,
  ) async {
    if (!state.flow.isInitial()) return;

    final fiatAmount = state.fiatAmount.copyWithDecimal(event.amount);
    final tokenAmount = _toTokenAmount(fiatAmount);

    if (tokenAmount == null) return;

    emit(state.copyWith(tokenAmount: tokenAmount, fiatAmount: fiatAmount));
  }

  Future<void> _onTokenUpdated(TokenUpdated event, _Emitter emit) async {
    if (!state.flow.isInitial()) return;

    if (!state.availableTokens.contains(event.token)) return;

    final currency = CryptoCurrency(token: event.token);
    final value = state.tokenAmount.decimal;
    final newAmount = state.tokenAmount.copyWith(
      currency: currency,
      value: currency.decimalToInt(value),
    );

    emit(
      state.copyWith(
        tokenAmount: newAmount,
        fiatAmount: _toFiatAmount(newAmount),
      ),
    );
  }

  Future<void> _onSubmitted(Submitted event, _Emitter emit) async {
    if (state.payerName.isEmpty) throw StateError('Payer name is empty.');

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
      payerName: state.payerName,
      payRequest: request,
      dynamicLink: request.toUniversalLink().toString(),
      state: PaymentRequestState.initial,
    );
    await _repository.save(paymentRequest);
    emit(state.copyWith(flow: Flow.success(paymentRequest)));
  }
}

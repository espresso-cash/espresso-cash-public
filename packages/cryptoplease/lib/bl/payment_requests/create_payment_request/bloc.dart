import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/flow.dart';
import 'package:cryptoplease/bl/payment_requests/payment_request.dart';
import 'package:cryptoplease/bl/payment_requests/repository.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
    FirebaseDynamicLinks? dynamicLinks,
  })  : _dynamicLinks = dynamicLinks ?? FirebaseDynamicLinks.instance,
        _repository = repository,
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

  final FirebaseDynamicLinks _dynamicLinks;
  final PaymentRequestRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        payerNameUpdated: (event) => _onPayerNameUpdated(event, emit),
        tokenAmountUpdated: (event) => _onAmountUpdated(event, emit),
        fiatAmountUpdated: (event) => _onFiatAmountUpdated(event, emit),
        tokenUpdated: (event) => _onTokenUpdated(event, emit),
        submitted: (event) => _onSubmitted(event, emit),
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
  ) async {}

  Future<void> _onFiatAmountUpdated(
    FiatAmountUpdated event,
    _Emitter emit,
  ) async {}

  Future<void> _onTokenUpdated(TokenUpdated event, _Emitter emit) async {}

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
    final String url = request.toUrl();

    final linkParams = DynamicLinkParameters(
      uriPrefix: 'https://cryptoplease.page.link',
      link: Uri.parse(url),
      androidParameters: const AndroidParameters(
        packageName: 'com.pleasecrypto.flutter',
        minimumVersion: 104,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.pleasecrypto.flutter',
        minimumVersion: '1.33.0',
      ),
    );

    try {
      final dynamicLink = await _dynamicLinks.buildShortLink(linkParams);
      final paymentRequest = PaymentRequest(
        id: const Uuid().v4(),
        created: DateTime.now(),
        payerName: state.payerName,
        payRequest: request,
        dynamicLink: dynamicLink.shortUrl.toString(),
        state: PaymentRequestState.initial,
      );
      await _repository.save(paymentRequest);
      emit(state.copyWith(flow: Flow.success(paymentRequest)));
    } on Exception catch (e) {
      emit(state.copyWith(flow: Flow.failure(e)));
    }
  }
}

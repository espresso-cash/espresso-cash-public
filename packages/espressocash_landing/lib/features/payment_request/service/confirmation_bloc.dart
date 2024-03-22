import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/flow.dart';
import '../../../../features/blockchain/models/blockchain.dart';
import '../../web3/web3_service.dart';
import '../data/repository.dart';
import '../models/incoming_quote.dart';
import '../models/request_model.dart';

part 'confirmation_bloc.freezed.dart';

typedef _Event = IncomingPaymentEvent;
typedef _State = IncomingPaymentState;
typedef _Emitter = Emitter<_State>;

@injectable
class IncomingPaymentBloc extends Bloc<_Event, _State> {
  IncomingPaymentBloc({
    required IncomingQuoteRepository quoteRepository,
    required Web3Service web3Service,
  })  : _quoteRepository = quoteRepository,
        _web3Service = web3Service,
        super(IncomingPaymentState(flowState: const Flow.initial())) {
    on<Init>(_onInit);
    on<AccountChanged>(_onWalletChanged);
    on<Confirmed>(_onConfirmed);
    on<ChainChanged>(
      _onChainChanged,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
    on<Invalidated>(
      _onInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );

    _chainChangedSubscription = _web3Service.chainChanged.listen((chainId) {
      final chain = chainId.fromHexChainId;

      add(ChainChanged(chain));
    });

    _accountsChangedSubscription =
        _web3Service.accountsChanged.listen((address) {
      add(AccountChanged(address));
    });
  }

  final IncomingQuoteRepository _quoteRepository;
  final Web3Service _web3Service;

  Timer? _timer;
  StreamSubscription<String>? _chainChangedSubscription;
  StreamSubscription<String>? _accountsChangedSubscription;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(_quoteDuration, () => add(const Invalidated()));
  }

  Future<void> _onInit(Init event, _Emitter emit) async {
    final account = await _web3Service.connect();

    final sender = UserWalletInfo(
      address: account.$1.toString(),
      blockchain: account.$2.blockchain ?? _defaultBlockchain,
    );

    emit(
      IncomingPaymentState(
        request: event.request,
        sender: sender,
        flowState: const Flow.processing(),
      ),
    );

    add(const Invalidated());
  }

  Future<void> _onChainChanged(ChainChanged event, _Emitter emit) async {
    if (event.chain == null) {
      emit(state.error(const PaymentException.unsupportedChain()));
    }

    final chain = event.chain ?? _defaultBlockchain;

    await _web3Service.switchChain(chain);

    emit(state.chainChanged(chain));

    add(const Invalidated());
  }

  void _onWalletChanged(AccountChanged event, _Emitter emit) {
    emit(state.walletUpdated(event.account));

    add(const Invalidated());
  }

  Future<void> _onConfirmed(Confirmed _, _Emitter emit) async {
    final quote = state.quote;

    if (quote == null) {
      emit(state.error(const PaymentException.quoteNotFound()));

      return;
    }

    _timer?.cancel();
    emit(
      state.copyWith(
        flowState: const Flow.processing(),
        expiresAt: null,
      ),
    );

    try {
      await _web3Service.approveContract(
        contractAddress: quote.usdcInfo.usdcAddress,
        amount: quote.usdcInfo.approvalAmount,
        to: quote.tx.to,
      );

      final tx = await _web3Service.sendTransaction(
        to: quote.tx.to,
        value: BigInt.from(quote.tx.value),
        data: quote.tx.data,
      );

      emit(state.copyWith(flowState: Flow.success((quote, tx))));
    } on Exception {
      emit(state.error(const PaymentException.other()));
    }
  }

  Future<void> _onInvalidated(Invalidated _, _Emitter emit) async {
    emit(state.processing());

    final request = state.request;
    final sender = state.sender;

    if (request == null || sender == null) {
      emit(state.error(const PaymentException.quoteNotFound()));

      return;
    }

    try {
      final quote = await _quoteRepository.getQuote(
        amount: request.requestAmount,
        receiverAddress: request.receiverAddress,
        senderAddress: sender.address,
        senderBlockchain: sender.blockchain,
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
    _chainChangedSubscription?.cancel();
    _accountsChangedSubscription?.cancel();

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
        expiresAt: DateTime.now().add(_quoteDuration),
      );

  IncomingPaymentState chainChanged(Blockchain chain) => copyWith(
        sender: sender?.copyWith(
          blockchain: chain,
        ),
      );

  IncomingPaymentState walletUpdated(String address) => copyWith(
        sender: sender?.copyWith(address: address),
      );
}

@Freezed(map: FreezedMapOptions.none, when: FreezedWhenOptions.none)
sealed class IncomingPaymentEvent with _$IncomingPaymentEvent {
  const factory IncomingPaymentEvent.init(IncomingPaymentRequest request) =
      Init;

  const factory IncomingPaymentEvent.chainChanged(Blockchain? chain) =
      ChainChanged;

  const factory IncomingPaymentEvent.accountsChanged(String account) =
      AccountChanged;

  const factory IncomingPaymentEvent.confirmed() = Confirmed;

  const factory IncomingPaymentEvent.invalidated() = Invalidated;
}

@freezed
class IncomingPaymentState with _$IncomingPaymentState {
  factory IncomingPaymentState({
    IncomingPaymentRequest? request,
    UserWalletInfo? sender,
    IncomingPaymentQuote? quote,
    @Default(Flow<PaymentException, (IncomingPaymentQuote, String)>.initial())
    Flow<PaymentException, (IncomingPaymentQuote, String)> flowState,
    DateTime? expiresAt,
  }) = Initialized;
}

extension IncomingPaymentStateExt on IncomingPaymentState {
  CryptoAmount get fee =>
      quote?.fee ?? const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);

  CryptoAmount get inputAmount =>
      quote?.inputAmount ??
      const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);

  CryptoAmount get totalAmount => (inputAmount + fee) as CryptoAmount;
}

@freezed
class PaymentException with _$PaymentException implements Exception {
  const factory PaymentException.other() = OtherException;

  const factory PaymentException.quoteNotFound() = QuoteNotFound;

  const factory PaymentException.unsupportedChain() = UnsupportedChain;
}

const _quoteDuration = Duration(seconds: 25);
const _defaultBlockchain = Blockchain.ethereum;

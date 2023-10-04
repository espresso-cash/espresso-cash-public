import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/flow.dart';
import '../../../../core/tokens/token.dart';
import '../../balances/data/balances_repository.dart';
import '../data/quote_repository.dart';
import '../models/dln_payment.dart';
import '../models/payment_quote.dart';

part 'confirm_payment_bloc.freezed.dart';
part 'confirm_payment_event.dart';
part 'confirm_payment_state.dart';

typedef _Event = ConfirmPaymentEvent;
typedef _State = ConfirmPaymentState;
typedef _Emitter = Emitter<_State>;

@injectable
class ConfirmPaymentBloc extends Bloc<_Event, _State> {
  ConfirmPaymentBloc({
    @factoryParam required this.payment,
    @factoryParam required Ed25519HDPublicKey userAccount,
    required QuoteRepository routeRepository,
    required BalancesRepository balancesRepository,
  })  : _routeRepository = routeRepository,
        _userAccount = userAccount,
        _usdcBalance = balancesRepository.readAll()[Token.usdc] ??
            Amount.zero(currency: Currency.usdc),
        super(
          // ignore: prefer_const_constructors
          ConfirmPaymentState(),
        ) {
    on<Confirmed>(_onConfirmed);
    on<RouteInvalidated>(
      _onRouteInvalidated,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );
  }

  final QuoteRepository _routeRepository;
  final Amount _usdcBalance;
  final Ed25519HDPublicKey _userAccount;
  final DlnPayment payment;

  void _onConfirmed(Confirmed _, _Emitter emit) {
    // state.validate(_usdcBalance).fold(
    //   (e) {
    //     emit(state.copyWith(flowState: Flow.failure(e)));
    //     emit(state.copyWith(flowState: const Flow.initial()));
    //   },
    //   (r) {
    //     emit(
    //       state.copyWith(
    //         flowState: Flow.success(r),
    //       ),
    //     );
    //   },
    // );

    emit(
      state.copyWith(
        flowState: Flow.success(state.quote!),
      ),
    );
  }

  Future<void> _onRouteInvalidated(RouteInvalidated _, _Emitter emit) async {
    emit(state.processing());

    try {
      final bestRoute = await _routeRepository.getQuote(
        amount: payment.amount,
        receiverAddress: payment.receiverAddress,
        receiverBlockchain: payment.receiverBlockchain,
        userPublicKey: _userAccount.toBase58(),
      );

      emit(state.update(bestRoute));
    } on CreateOrderException catch (error) {
      emit(state.error(error));
    } on Exception {
      emit(state.error(const CreateOrderException.routeNotFound()));
    }
  }
}

extension BalanceExt on IMap<Token, Amount> {
  bool isPositive(Token token) {
    final balance = this[token];

    return balance != null && balance.value > 0;
  }

  CryptoAmount balanceFromToken(Token token) {
    final balance = this[token];
    final value = balance?.value ?? 0;

    return CryptoAmount(
      value: value,
      cryptoCurrency: CryptoCurrency(token: token),
    );
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

  ConfirmPaymentState reset() => copyWith(
        quote: null,
        flowState: const Flow.initial(),
        expiresAt: null,
      );
}

extension on Token {
  CryptoAmount toZeroAmount() => CryptoAmount(
        value: 0,
        cryptoCurrency: CryptoCurrency(token: this),
      );
}

const _quoteDuration = Duration(seconds: 20);

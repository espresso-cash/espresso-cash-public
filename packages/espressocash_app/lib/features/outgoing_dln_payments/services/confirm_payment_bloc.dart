import 'dart:async';

import 'package:dfunc/dfunc.dart';
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
    required QuoteRepository quoteRepository,
    required BalancesRepository balancesRepository,
  })  : _quoteRepository = quoteRepository,
        _userAccount = userAccount,
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
  final Ed25519HDPublicKey _userAccount;
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
        userPublicKey: _userAccount.toBase58(),
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

const _quoteDuration = Duration(seconds: 20);

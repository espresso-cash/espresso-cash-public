import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/core/split_key_payments/split_key_api_version.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
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
    required Map<Token, Amount> balances,
    required CryptopleaseClient cryptopleaseClient,
    required MyAccount myAccount,
    required OutgoingTransferRepository repository,
  })  : _balances = balances,
        _cpClient = cryptopleaseClient,
        _myAccount = myAccount,
        _repository = repository,
        super(const RequestPayState(amount: _defaultAmount)) {
    on<_Event>(_eventHandler);
  }

  static const _defaultAmount = CryptoAmount(
    value: 0,
    currency: CryptoCurrency(token: Token.usdc),
  );

  final Map<Token, Amount> _balances;
  final CryptopleaseClient _cpClient;
  final MyAccount _myAccount;
  final OutgoingTransferRepository _repository;

  _EventHandler get _eventHandler => (event, emit) => event.map(
        amountUpdated: (event) => _onAmountUpdated(event, emit),
        recipientUpdated: (event) => _onRecipientUpdated(event, emit),
        cleared: (_) => _onCleared(emit),
        directSubmitted: (_) => _onDirectSubmitted(emit),
      );

  void _onCleared(_Emitter emit) {
    emit(RequestPayState(amount: state.amount));
  }

  void _onRecipientUpdated(_RecipientUpdated event, _Emitter emit) {
    emit(state.copyWith(recipient: event.recipient));
  }

  void _onAmountUpdated(_AmountUpdated event, _Emitter emit) {
    emit(state.copyWith(amount: state.amount.copyWithDecimal(event.amount)));
  }

  Future<void> _onDirectSubmitted(_Emitter emit) async {
    final recipient = state.recipient;
    final amount = state.amount.value;
    final sender = _myAccount.address;

    if (recipient == null) return;

    emit(state.toProcessing());

    try {
      final request = CreateDirectPaymentRequestDto(
        senderAccount: sender,
        receiverAccount: recipient,
        amount: amount,
        cluster: isProd ? Cluster.mainnet : Cluster.devnet,
      );
      final directPayment = await _cpClient.createDirectPayment(request);
      final payment = OutgoingTransfer.createDirectTransfer(
        recipientAddress: recipient,
        amount: amount,
        tokenAddress: state.amount.token.address,
        tokenType: OutgoingTransferTokenType.fungibleToken,
        apiVersion: SplitKeyApiVersion.v2,
        state: OutgoingTransferState.draft(
          encodedTx: directPayment.transaction,
        ),
      );

      await _repository.save(payment);

      final fee = state.amount.copyWith(value: directPayment.fee);

      emit(
        state.withPayment(
          DirectTransferState(fee: fee, paymentId: payment.id),
        ),
      );
    } on Exception catch (e) {
      emit(state.toFailure(e));
    }
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

    final fee = state.fee;
    var feeBalance = _balances[fee.currency.token] ?? fee.copyWith(value: 0);
    if (token == fee.currency.token) {
      feeBalance -= state.amount;
    }

    if (feeBalance < fee) {
      return Either.left(ValidationError.insufficientFee(fee));
    }

    return const Either.right(null);
  }
}

extension on RequestPayState {
  RequestPayState toFailure(Exception e) => copyWith(
        processingState: ProcessingState.error(e),
      );

  RequestPayState toProcessing() => copyWith(
        processingState: const ProcessingState.processing(),
      );

  RequestPayState withPayment(DirectTransferState directTransfer) => copyWith(
        processingState: const ProcessingState.none(),
        directTransfer: directTransfer,
      );
}

import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/flow.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = FtCreateOutgoingTransferEvent;
typedef _State = FtCreateOutgoingTransferState;
typedef _Emitter = Emitter<_State>;

/// This BLoC is responsible for preparing necessary data for outgoing transfer
/// and creating the transfer.
///
/// No actual sending is done within this BLoC, it only creates the transfer
/// and stores it in the [OutgoingTransferRepository].
class FtCreateOutgoingTransferBloc extends Bloc<_Event, _State> {
  FtCreateOutgoingTransferBloc({
    required OutgoingTransferRepository repository,
    required Map<Token, Amount> balances,
    required ConversionRatesRepository conversionRatesRepository,
    required FiatCurrency userCurrency,
    required OutgoingTransferType transferType,
    String? memo,
    Iterable<Ed25519HDPublicKey>? reference,
    Token? initialToken,
  })  : _repository = repository,
        _balances = balances,
        _conversionRatesRepository = conversionRatesRepository,
        super(
          _State(
            tokenAmount: initialToken == null
                ? const CryptoAmount(value: 0, currency: Currency.sol)
                : CryptoAmount(
                    value: 0,
                    currency: CryptoCurrency(token: initialToken),
                  ),
            fiatAmount: FiatAmount(value: 0, currency: userCurrency),
            availableTokens: initialToken == null
                ? IList(balances.keys)
                : IList([initialToken]),
            transferType: transferType,
            memo: memo,
            reference: reference,
          ),
        ) {
    on<_Event>(_handler);
  }

  final OutgoingTransferRepository _repository;
  final Map<Token, Amount> _balances;
  final ConversionRatesRepository _conversionRatesRepository;

  /// Call this method before submitting the transfer to catch validation
  /// errors.
  ///
  /// It will be called by BLoC when creating the transfer anyway, but it
  /// can be called manually on an earlier stage to e.g. display dialog
  /// about insufficient balance.
  Either<ValidationError, void> validate() {
    final token = state.token;
    final userBalance = _balances[token] ??
        Amount.zero(currency: Currency.crypto(token: token));

    if (userBalance < state.tokenAmount) {
      return Either.left(
        ValidationError.insufficientFunds(
          balance: userBalance,
          currentAmount: state.tokenAmount,
        ),
      );
    }

    var feeBalance =
        _balances[Token.sol] ?? Amount.zero(currency: Currency.sol);
    if (token == Token.sol) {
      feeBalance -= state.tokenAmount;
    }

    if (feeBalance < state.fee) {
      return Either.left(ValidationError.insufficientFee(state.fee));
    }

    return const Either.right(null);
  }

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        maxRequested: (_) => _onMaxRequested(emit),
        tokenAmountUpdated: (event) => _onAmountUpdated(event, emit),
        fiatAmountUpdated: (event) => _onFiatAmountUpdated(event, emit),
        tokenUpdated: (event) => _onTokenUpdated(event, emit),
        recipientUpdated: (event) => _onRecipientUpdated(event, emit),
        memoUpdated: (event) => _onMemoUpdated(event, emit),
        referenceUpdated: (event) => _onReferenceUpdated(event, emit),
        cleared: (_) => _onCleared(emit),
        submitted: (_) => _onSubmitted(emit),
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

  Future<void> _onMaxRequested(_Emitter emit) async {
    if (!state.flow.isInitial()) return;

    final balance = _balances[state.token] as CryptoAmount? ??
        CryptoAmount(value: 0, currency: state.tokenAmount.currency);
    final CryptoAmount amount = state.token == Token.sol
        ? balance - state.fee as CryptoAmount
        : balance;

    final tokenAmount = amount.value >= 0 ? amount : amount.copyWith(value: 0);
    final fiatAmount = _toFiatAmount(tokenAmount);

    emit(state.copyWith(tokenAmount: tokenAmount, fiatAmount: fiatAmount));
  }

  Future<void> _onAmountUpdated(TokenAmountUpdated event, _Emitter emit) async {
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

  Future<void> _onRecipientUpdated(
    RecipientUpdated event,
    _Emitter emit,
  ) async {
    if (!state.flow.isInitial()) return;

    emit(state.copyWith(recipientAddress: event.address));
  }

  Future<void> _onMemoUpdated(MemoUpdated event, _Emitter emit) async {
    if (!state.flow.isInitial()) return;

    emit(state.copyWith(memo: event.memo));
  }

  Future<void> _onReferenceUpdated(
    ReferenceUpdated event,
    _Emitter emit,
  ) async {
    if (!state.flow.isInitial()) return;

    emit(state.copyWith(reference: event.reference));
  }

  Future<void> _onCleared(_Emitter emit) async {
    if (!state.flow.isInitial()) return;

    emit(
      _State(
        tokenAmount: const CryptoAmount(value: 0, currency: Currency.sol),
        fiatAmount: state.fiatAmount.copyWith(value: 0),
        availableTokens: IList(_balances.keys),
        transferType: OutgoingTransferType.direct,
      ),
    );
  }

  Future<void> _onSubmitted(_Emitter emit) async => tryEitherAsync(
        (bind) async {
          if (!state.flow.isInitial()) return;

          bind(validate());

          emit(state.copyWith(flow: const Flow.processing()));

          final OutgoingTransfer payment;
          switch (state.transferType) {
            case OutgoingTransferType.splitKey:
              payment = await OutgoingTransfer.createSplitKeyTransfer(
                amount: state.tokenAmount.value,
                tokenAddress: state.token.address,
                tokenType: OutgoingTransferTokenType.fungibleToken,
              );
              break;
            case OutgoingTransferType.direct:
              payment = OutgoingTransfer.createDirectTransfer(
                // ignore: avoid-non-null-assertion, recipientAddress should be filled by this step
                recipientAddress: state.recipientAddress!,
                amount: state.tokenAmount.value,
                tokenAddress: state.token.address,
                memo: state.memo,
                reference: state.reference,
                tokenType: OutgoingTransferTokenType.fungibleToken,
              );
              break;
          }

          await _repository.save(payment);

          emit(state.copyWith(flow: Flow.success(payment.id)));
        },
      ).doOnLeftAsync((e) {
        emit(state.copyWith(flow: Flow.failure(e)));
        emit(state.copyWith(flow: const Flow.initial()));
      });
}

@freezed
class ValidationError with _$ValidationError implements Exception {
  const factory ValidationError.insufficientFunds({
    required Amount currentAmount,
    required Amount balance,
  }) = InsufficientFunds;

  const factory ValidationError.insufficientFee(Amount requiredFee) =
      InsufficientFee;
}

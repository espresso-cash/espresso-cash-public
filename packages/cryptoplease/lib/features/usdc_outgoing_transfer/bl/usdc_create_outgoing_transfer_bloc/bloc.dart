import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/conversion_rates/bl/repository.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/flow.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/wallet.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = UsdcCreateOutgoingTransferEvent;
typedef _State = UsdcCreateOutgoingTransferState;
typedef _Emitter = Emitter<_State>;

/// This BLoC is responsible for preparing necessary data for outgoing transfer
/// and creating the transfer.
///
/// No actual sending is done within this BLoC, it only creates the transfer
/// and stores it in the [OutgoingTransferRepository].
class UsdcCreateOutgoingTransferBloc extends Bloc<_Event, _State> {
  UsdcCreateOutgoingTransferBloc({
    required OutgoingTransferRepository repository,
    required Map<Token, Amount> balances,
    required ConversionRatesRepository conversionRatesRepository,
  })  : _repository = repository,
        _balances = balances,
        _conversionRatesRepository = conversionRatesRepository,
        super(
          const UsdcCreateOutgoingTransferState(
            tokenAmount: CryptoAmount(currency: Currency.usdc, value: 0),
            fiatAmount: FiatAmount(currency: Currency.usd, value: 0),
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
    final userBalance =
        _balances[Token.usdc] ?? Amount.zero(currency: Currency.usdc);

    if (userBalance < state.tokenAmount) {
      return Either.left(
        ValidationError.insufficientFunds(
          balance: userBalance,
          currentAmount: state.tokenAmount,
        ),
      );
    }

    final total = state.tokenAmount + state.fee;

    if (userBalance < total) {
      return Either.left(ValidationError.insufficientFee(state.fee));
    }

    return const Either.right(null);
  }

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        tokenAmountUpdated: (event) => _onAmountUpdated(event, emit),
        cleared: (_) => _onCleared(emit),
        submitted: (_) => _onSubmitted(emit),
      );

  FiatAmount _toFiatAmount(CryptoAmount tokenAmount) =>
      tokenAmount.toFiatAmount(
        state.fiatAmount.currency,
        ratesRepository: _conversionRatesRepository,
      ) ??
      state.fiatAmount.copyWith(value: 0);

  Future<void> _onAmountUpdated(TokenAmountUpdated event, _Emitter emit) async {
    if (!state.flow.isInitial()) return;

    final tokenAmount = state.tokenAmount.copyWithDecimal(event.amount);
    final fiatAmount = _toFiatAmount(tokenAmount);

    emit(state.copyWith(tokenAmount: tokenAmount, fiatAmount: fiatAmount));
  }

  Future<void> _onCleared(_Emitter emit) async {
    if (!state.flow.isInitial()) return;

    emit(
      _State(
        tokenAmount: const CryptoAmount(value: 0, currency: Currency.usdc),
        fiatAmount: state.fiatAmount.copyWith(value: 0),
      ),
    );
  }

  Future<void> _onSubmitted(_Emitter emit) async => tryEitherAsync(
        (bind) async {
          if (!state.flow.isInitial()) return;

          bind(validate());

          emit(state.copyWith(flow: const Flow.processing()));

          final escrowAccount = await createRandomKeyPair();
          final amount = state.tokenAmount.value.toInt();

          final payment = await _createSplitKeyTransfer(
            recipient: escrowAccount,
            amount: amount,
          );

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

Future<OutgoingTransferSplitKey> _createSplitKeyTransfer({
  required Wallet recipient,
  required int amount,
}) async =>
    OutgoingTransferSplitKey(
      id: const Uuid().v4().toString(),
      created: DateTime.now(),
      privateKey: (await recipient.extract()).bytes.lock,
      amount: amount,
      tokenAddress: Token.usdc.address,
      state: const OutgoingTransferState.draft(),
      tokenType: OutgoingTransferTokenType.fungibleToken,
    );

import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/flow.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/metaplex.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = NftCreateOutgoingTransferEvent;
typedef _State = NftCreateOutgoingTransferState;
typedef _Emitter = Emitter<_State>;

/// This BLoC is responsible for preparing necessary data for outgoing transfer
/// and creating the transfer.
///
/// No actual sending is done within this BLoC, it only creates the transfer
/// and stores it in the [OutgoingTransferRepository].
class NftCreateOutgoingTransferBloc extends Bloc<_Event, _State> {
  NftCreateOutgoingTransferBloc({
    required OutgoingTransferRepository repository,
    required Map<Token, Amount> balances,
  })  : _repository = repository,
        _balances = balances,
        super(
          const _State(
            transferType: OutgoingTransferType.direct,
          ),
        ) {
    on<_Event>(_handler);
  }

  final OutgoingTransferRepository _repository;
  final Map<Token, Amount> _balances;

  /// Call this method before submitting the transfer to catch validation
  /// errors.
  ///
  /// It will be called by BLoC when creating the transfer anyway, but it
  /// can be called manually on an earlier stage to e.g. display dialog
  /// about insufficient balance.
  Either<ValidationError, void> validate() {
    final feeBalance =
        _balances[Token.sol] ?? Amount.zero(currency: Currency.sol);

    if (feeBalance < state.fee) {
      return Either.left(ValidationError.insufficientFee(state.fee));
    }

    return const Either.right(null);
  }

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        typeUpdated: (event) => _onTypeUpdated(event, emit),
        recipientUpdated: (event) => _onRecipientUpdated(event, emit),
        memoUpdated: (event) => _onMemoUpdated(event, emit),
        referenceUpdated: (event) => _onReferenceUpdated(event, emit),
        cleared: (_) => _onCleared(emit),
        submitted: (_) => _onSubmitted(emit),
        nftTransferCreated: (event) => _onNftTransferCreated(event, emit),
      );

  Future<void> _onTypeUpdated(TypeUpdated event, _Emitter emit) async {
    if (!state.flow.isInitial()) return;

    emit(state.copyWith(transferType: event.transferType));
  }

  Future<void> _onNftTransferCreated(
    NftTransferCreated event,
    _Emitter emit,
  ) async {
    if (!state.flow.isInitial()) return;

    emit(
      state.copyWith(
        nft: event.token,
        offChainMetadata: event.offChainMetadata,
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
      const _State(
        transferType: OutgoingTransferType.direct,
      ),
    );
  }

  Future<void> _onSubmitted(_Emitter emit) async => tryEitherAsync(
        (bind) async {
          if (!state.flow.isInitial()) return;

          bind(validate());

          emit(state.copyWith(flow: const Flow.processing()));

          const amount = 1;

          final OutgoingTransfer payment;
          switch (state.transferType) {
            case OutgoingTransferType.splitKey:
              payment = await OutgoingTransfer.createSplitKeyTransfer(
                amount: amount,
                tokenAddress: state.token.address,
                tokenType: OutgoingTransferTokenType.nonFungibleToken,
              );
              break;
            case OutgoingTransferType.direct:
              payment = OutgoingTransfer.createDirectTransfer(
                recipientAddress: state.recipientAddress!,
                amount: amount,
                tokenAddress: state.token.address,
                memo: state.memo,
                reference: state.reference,
                tokenType: OutgoingTransferTokenType.nonFungibleToken,
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

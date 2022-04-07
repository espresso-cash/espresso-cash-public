import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/flow.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

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
    required NonFungibleToken nft,
    required OutgoingTransferType transferType,
  })  : _repository = repository,
        _balances = balances,
        super(_State(transferType: transferType, nft: nft)) {
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

    final fee = state.fee;

    if (feeBalance < fee) {
      return Either.left(ValidationError.insufficientFee(fee));
    }

    return const Either.right(null);
  }

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        recipientUpdated: (event) => _onRecipientUpdated(event, emit),
        memoUpdated: (event) => _onMemoUpdated(event, emit),
        referenceUpdated: (event) => _onReferenceUpdated(event, emit),
        cleared: (_) => _onCleared(emit),
        submitted: (_) => _onSubmitted(emit),
      );

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

    emit(_State(transferType: OutgoingTransferType.direct, nft: state.nft));
  }

  Future<void> _onSubmitted(_Emitter emit) async => tryEitherAsync(
        (bind) async {
          if (!state.flow.isInitial()) return;

          final address = state.nft.address;

          bind(validate());

          emit(state.copyWith(flow: const Flow.processing()));

          const amount = 1;

          final OutgoingTransfer payment;
          switch (state.transferType) {
            case OutgoingTransferType.splitKey:
              payment = await OutgoingTransfer.createSplitKeyTransfer(
                amount: amount,
                tokenAddress: address,
                tokenType: OutgoingTransferTokenType.nonFungibleToken,
              );
              break;
            case OutgoingTransferType.direct:
              payment = OutgoingTransfer.createDirectTransfer(
                recipientAddress: state.recipientAddress!,
                amount: amount,
                tokenAddress: address,
                memo: state.memo,
                reference: state.reference
                    ?.let((it) => IList([Ed25519HDPublicKey.fromBase58(it)])),
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

  const factory ValidationError.invalidToken() = InvalidToken;
}

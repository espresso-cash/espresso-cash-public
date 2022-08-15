import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/core/processing_state.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/models.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/repository.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/tx_processor.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = SplitKeyIncomingPaymentEvent;
typedef _State = SplitKeyIncomingPayment;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class SplitKeyIncomingPaymentBloc extends Bloc<_Event, _State> {
  SplitKeyIncomingPaymentBloc({
    required SplitKeyIncomingRepository repository,
    required TxProcessor txProcessor,
  })  : _repository = repository,
        _txProcessor = txProcessor,
        super(const SplitKeyIncomingPayment.none()) {
    on<_Event>(_handler, transformer: sequential());
  }

  final SplitKeyIncomingRepository _repository;
  final TxProcessor _txProcessor;

  _EventHandler get _handler => (e, emit) => e.map(
        firstPartAdded: (e) => _onFirstPartAdded(e, emit),
        secondPartAdded: (e) => _onSecondPartAdded(e, emit),
        paymentRequested: (e) => _onPaymentRequested(e, emit),
        retried: (e) => _onRetried(e, emit),
        cleared: (e) => _onCleared(e, emit),
      );

  Future<void> _onFirstPartAdded(FirstPartAdded event, _Emitter emit) async {
    emit(
      SplitKeyIncomingPayment.firstPartReady(
        firstPart: event.firstPart.keyPart,
        tokenAddress: event.firstPart.tokenAddress,
      ),
    );
    await _repository.save(event.firstPart);
  }

  Future<void> _onSecondPartAdded(SecondPartAdded event, _Emitter emit) async {
    final updated = await state.map(
      none: (s) async {
        final existing = await _repository.watch().first;
        if (existing == null) return s;

        return SplitKeyIncomingPayment.secondPartReady(
          firstPart: existing.keyPart,
          tokenAddress: existing.tokenAddress,
          secondPart: event.value.key,
        );
      },
      firstPartReady: (s) async => SplitKeyIncomingPayment.secondPartReady(
        firstPart: s.firstPart,
        tokenAddress: s.tokenAddress,
        secondPart: event.value.key,
      ),
      secondPartReady: (s) async => SplitKeyIncomingPayment.secondPartReady(
        firstPart: s.firstPart,
        tokenAddress: s.tokenAddress,
        secondPart: event.value.key,
      ),
      success: (s) async => s,
    );
    emit(updated);
    await _repository.clear();
  }

  Future<void> _onPaymentRequested(
    PaymentRequested event,
    _Emitter emit,
  ) async {
    final state = this.state;
    if (state is! PaymentSecondPartReady) return;

    emit(state.copyWith(processingState: const ProcessingState.processing()));
    final updated = await _txProcessor
        .createTx(
          firstPart: state.firstPart,
          secondPart: state.secondPart,
          recipient: event.recipient,
          tokenAddress: state.tokenAddress,
        )
        .foldAsync(
          (e) => e.toFlow(),
          (tx) => _txProcessor.sendPayment(tx).flatMapAsync(_txProcessor.wait),
        )
        .toState(state: state);
    emit(updated);
  }

  Future<void> _onRetried(Retried event, _Emitter emit) async {
    final state = this.state;
    if (state is! PaymentSecondPartReady) return;

    final error = state.processingState.whenOrNull(error: identity);
    if (error == null) return;

    final SplitKeyIncomingPayment newState = await error.when(
      consumed: () async => state,
      invalidTx: () async {
        add(PaymentRequested(recipient: event.recipient));

        return state;
      },
      invalidLink: () async => state,
      failedToSubmit: (tx) => _txProcessor
          .sendPayment(tx)
          .flatMapAsync(_txProcessor.wait)
          .toState(state: state),
      failedToConfirm: (tx) => _txProcessor.wait(tx).toState(state: state),
    );
    emit(newState);
  }

  Future<void> _onCleared(PaymentCleared _, _Emitter emit) async {
    emit(const SplitKeyIncomingPayment.none());
  }
}

typedef _Flow = AsyncEither<SplitKeyIncomingPaymentError, void>;

extension on _Flow {
  Future<SplitKeyIncomingPayment> toState({
    required PaymentSecondPartReady state,
  }) =>
      foldAsync(
        (e) => state.copyWith(processingState: ProcessingState.error(e)),
        (_) => const SplitKeyIncomingPayment.success(),
      );
}

extension on TxCreationError {
  _Flow toFlow() => when(
        invalidLink: () async => const Either.left(ErrorInvalidLink()),
        consumedByRecipient: () async => const Either.right(null),
        consumedByOther: () async => const Either.left(ErrorConsumed()),
        other: () async => const Either.left(ErrorInvalidTx()),
      );
}

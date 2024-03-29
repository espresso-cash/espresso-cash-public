import 'package:freezed_annotation/freezed_annotation.dart';

part 'processing_state.freezed.dart';

@Freezed(
  when: FreezedWhenOptions.none,
  map: FreezedMapOptions.none,
  copyWith: false,
)
sealed class ProcessingState<E extends Exception> with _$ProcessingState<E> {
  const factory ProcessingState.none() = ProcessingStateNone;

  const factory ProcessingState.processing() = ProcessingStateProcessing;

  const factory ProcessingState.error(E e) = ProcessingStateError;

  const ProcessingState._();

  bool get isProcessing => this is ProcessingStateProcessing;
}

abstract class StateWithProcessingState {
  const StateWithProcessingState();

  ProcessingState get processingState;
}

ProcessingStateNone none() => const ProcessingStateNone();
ProcessingStateProcessing processing() => const ProcessingStateProcessing();
ProcessingStateError<E> error<E extends Exception>(E e) =>
    ProcessingStateError(e);

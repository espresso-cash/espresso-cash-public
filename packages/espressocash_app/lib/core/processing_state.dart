import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'processing_state.freezed.dart';

@freezed
class ProcessingState<E extends Exception> with _$ProcessingState<E> {
  const factory ProcessingState.none() = ProcessingStateNone;

  const factory ProcessingState.processing() = ProcessingStateProcessing;

  const factory ProcessingState.error(E e) = ProcessingStateError;

  const ProcessingState._();

  bool get isProcessing => maybeWhen(processing: T, orElse: F);
}

abstract class StateWithProcessingState {
  ProcessingState get processingState;
}

ProcessingStateNone<E> none<E extends Exception>() =>
    const ProcessingStateNone();
ProcessingStateProcessing<E> processing<E extends Exception>() =>
    const ProcessingStateProcessing();
ProcessingStateError<E> error<E extends Exception>(E e) =>
    ProcessingStateError(e);

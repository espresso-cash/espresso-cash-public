import 'package:freezed_annotation/freezed_annotation.dart';

part 'flow.freezed.dart';

/// Provides processing flow with possible result of type [R] or error
/// of type [E].
///
/// If you don't care about the result, you can use `ProcessingState` insted.
@freezed
class Flow<E extends Exception, R> with _$Flow<E, R> {
  const factory Flow.initial() = FlowInitial;

  const factory Flow.processing() = FlowProcessing;

  const factory Flow.failure(E error) = FlowFailure;

  const factory Flow.success(R result) = FlowSuccess;

  const Flow._();

  bool isInitial() => this is FlowInitial;

  bool isProcessing() => this is FlowProcessing;

  bool isFailure() => this is FlowFailure;

  bool isSuccess() => this is FlowSuccess;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'flow.freezed.dart';

/// Provides processing flow with possible result of type [R] or error
/// of type [E].
///
/// If you don't care about the result, you can use `ProcessingState` insted.
@Freezed(copyWith: false)
sealed class Flow<E extends Exception, R> with _$Flow<E, R> {
  const factory Flow.initial() = FlowInitial;

  const factory Flow.processing() = FlowProcessing;

  const factory Flow.failure(E error) = FlowFailure;

  const factory Flow.success(R result) = FlowSuccess;

  const Flow._();

  bool get isInitial => this is FlowInitial;

  bool get isProcessing => this is FlowProcessing;

  bool get isFailure => this is FlowFailure;

  bool get isSuccess => this is FlowSuccess;
}

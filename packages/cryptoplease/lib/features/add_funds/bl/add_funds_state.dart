part of 'add_funds_bloc.dart';

@freezed
class AddFundsState with _$AddFundsState {
  const factory AddFundsState.initialized({
    required FiatAmount inputAmount,
    required FiatAmount minAmount,
    AddFundsQuote? quote,
    @Default(ProcessingState.none()) ProcessingState processingState,
  }) = _Initialized;

  const factory AddFundsState.loading() = _Loading;

  const factory AddFundsState.failure() = _Failure;

  const factory AddFundsState.success(String url) = _Success;
}

extension AddFundsStateExt on AddFundsState {
  bool isLoading() => maybeMap(
        orElse: F,
        loading: T,
        initialized: (state) => state.processingState.isProcessing,
      );

  bool isValidAmount() => maybeMap(
        orElse: F,
        initialized: (state) =>
            state.inputAmount.value != 0 &&
            state.inputAmount >= state.minAmount,
      );
}

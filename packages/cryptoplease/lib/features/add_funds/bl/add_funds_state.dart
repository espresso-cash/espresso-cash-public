part of 'add_funds_bloc.dart';

@freezed
class AddFundsState with _$AddFundsState {
  const factory AddFundsState.initialized({
    required FiatAmount inputAmount,
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
}

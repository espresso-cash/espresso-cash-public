part of 'bloc.dart';

enum SwapEditingMode { input, output }

@freezed
class CreateSwapState with _$CreateSwapState {
  const factory CreateSwapState({
    required CryptoAmount inputAmount,
    required CryptoAmount outputAmount,
    required Decimal slippage,
    @Default(SwapEditingMode.input) SwapEditingMode editingMode,
    JupiterRoute? bestRoute,
    @Default(ProcessingState.none())
        ProcessingState<SwapException> processingState,
  }) = Initialized;
}

extension InitializedExt on CreateSwapState {
  Token get input => inputAmount.token;
  Token get output => outputAmount.token;

  Token get requestToken => requestAmount.token;

  CryptoAmount get requestAmount =>
      editingMode == SwapEditingMode.input ? inputAmount : outputAmount;

  SwapMode get swapMode => editingMode == SwapEditingMode.input
      ? SwapMode.exactIn
      : SwapMode.exactOut;
}

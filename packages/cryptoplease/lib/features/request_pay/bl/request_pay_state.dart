part of 'request_pay_bloc.dart';

@freezed
class RequestPayState with _$RequestPayState {
  const factory RequestPayState({
    required Token token,
    required CryptoAmount amount,
    required Iterable<Token> availableTokens,
    required ProcessingState processingState,
  }) = _RequestPayState;
}

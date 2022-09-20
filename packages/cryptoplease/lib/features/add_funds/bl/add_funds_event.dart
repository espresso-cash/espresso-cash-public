part of 'add_funds_bloc.dart';

@freezed
class AddFundsEvent with _$AddFundsEvent {
  const factory AddFundsEvent.urlRequested({
    required String walletAddress,
  }) = _UrlRequested;

  const factory AddFundsEvent.amountUpdated({
    required Decimal decimal,
  }) = _AmountUpdated;

  const factory AddFundsEvent.outputInvalidated() = _OutputInvalidated;
}

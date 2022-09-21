part of 'add_funds_bloc.dart';

@freezed
class AddFundsEvent with _$AddFundsEvent {
  const factory AddFundsEvent.urlRequested({
    required String walletAddress,
  }) = _UrlRequestedEvent;

  const factory AddFundsEvent.amountUpdated({
    required Decimal decimal,
  }) = _AmountUpdatedEvent;

  const factory AddFundsEvent.initialized() = _InitializedEvent;
}

part of 'bloc.dart';

@freezed
class TxFetcherEvent with _$TxFetcherEvent {
  const factory TxFetcherEvent.fetchRequested() = FetchRequested;

  const factory TxFetcherEvent.moreRequested() = MoreRequested;
}

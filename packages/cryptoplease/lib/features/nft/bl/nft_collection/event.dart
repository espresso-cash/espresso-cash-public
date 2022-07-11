part of 'bloc.dart';

@freezed
class NftCollectionEvent with _$NftCollectionEvent {
  const factory NftCollectionEvent.updated() = NftCollectionEventUpdated;
}

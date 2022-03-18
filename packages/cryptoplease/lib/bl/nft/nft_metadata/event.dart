part of 'bloc.dart';

@freezed
class NftMetadataEvent with _$NftMetadataEvent {
  const factory NftMetadataEvent.initialized(Metadata metadata) =
      NftMetadataEventInitialized;
}

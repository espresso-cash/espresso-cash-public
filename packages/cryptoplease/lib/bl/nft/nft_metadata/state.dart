part of 'bloc.dart';

@freezed
class NftMetadataState with _$NftMetadataState {
  const factory NftMetadataState({
    OffChainMetadata? data,
    @Default(ProcessingState.processing()) ProcessingState processingState,
  }) = _NftMetadataState;
}

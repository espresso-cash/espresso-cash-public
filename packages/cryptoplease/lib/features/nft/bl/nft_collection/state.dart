part of 'bloc.dart';

@freezed
class NftCollectionState with _$NftCollectionState {
  const factory NftCollectionState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
    @Default(IListConst<NonFungibleToken>([]))
        IList<NonFungibleToken> nftCollection,
  }) = _NftCollectionState;
}

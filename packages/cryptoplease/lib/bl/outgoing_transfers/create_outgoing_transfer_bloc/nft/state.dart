part of 'bloc.dart';

@freezed
class NftCreateOutgoingTransferState with _$NftCreateOutgoingTransferState {
  const factory NftCreateOutgoingTransferState({
    required OutgoingTransferType transferType,
    required NonFungibleToken nft,
    Amount? maxFee,
    String? recipientAddress,
    String? memo,
    String? reference,
    @Default(FlowInitial<Exception, OutgoingTransferId>())
        Flow<Exception, OutgoingTransferId> flow,
  }) = _NftCreateOutgoingTransferState;

  const NftCreateOutgoingTransferState._();

  Amount get fee => calculateFee(transferType, nft.address);
}

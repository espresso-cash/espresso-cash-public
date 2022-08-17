part of 'bloc.dart';

@freezed
class UsdcCreateOutgoingTransferState with _$UsdcCreateOutgoingTransferState {
  const factory UsdcCreateOutgoingTransferState({
    required CryptoAmount tokenAmount,
    required FiatAmount fiatAmount,
    @Default(FlowInitial<Exception, OutgoingTransferId>())
        Flow<Exception, OutgoingTransferId> flow,
  }) = _UsdcCreateOutgoingTransferState;

  const UsdcCreateOutgoingTransferState._();

  Amount get fee => calculateFee(
        OutgoingTransferType.splitKey,
        Token.usdc.address,
      );
}

part of 'bloc.dart';

@freezed
class FtCreateOutgoingTransferState with _$FtCreateOutgoingTransferState {
  const factory FtCreateOutgoingTransferState({
    required IList<Token> availableTokens,
    required OutgoingTransferType transferType,
    required CryptoAmount tokenAmount,
    required FiatAmount fiatAmount,
    Amount? maxFee,
    String? recipientAddress,
    String? memo,
    String? reference,
    @Default(FlowInitial<Exception, OutgoingTransferId>())
        Flow<Exception, OutgoingTransferId> flow,
  }) = _FtCreateOutgoingTransferState;

  const FtCreateOutgoingTransferState._();

  Amount get fee => calculateFee(
        transferType,
        tokenAmount.currency.token.address,
      );

  Token get token => tokenAmount.currency.token;
}

part of 'bloc.dart';

@freezed
class CreateOutgoingTransferState with _$CreateOutgoingTransferState {
  const factory CreateOutgoingTransferState({
    required IList<Token> availableTokens,
    required OutgoingTransferType transferType,
    required OutgoingTransferTokenType tokenType,
    required CryptoAmount tokenAmount,
    required FiatAmount fiatAmount,
    Amount? maxFee,
    String? recipientAddress,
    String? memo,
    String? reference,
    @Default(FlowInitial<Exception, OutgoingTransferId>())
        Flow<Exception, OutgoingTransferId> flow,
  }) = _CreateOutgoingTransferState;

  const CreateOutgoingTransferState._();

  Amount get fee => calculateFee(
        transferType,
        tokenAmount.currency.token.address,
      );

  Token get token => tokenAmount.currency.token;
}

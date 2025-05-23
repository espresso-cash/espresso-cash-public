part of 'bloc.dart';

@freezed
sealed class MobileWalletState with _$MobileWalletState {
  const factory MobileWalletState.none() = None;
  const factory MobileWalletState.sessionTerminated() = SessionTerminated;
  const factory MobileWalletState.remote(RemoteRequest request) = Remote;
}

@freezed
class RemoteRequest with _$RemoteRequest {
  const factory RemoteRequest.authorizeDapp({required AuthorizeRequest request}) = AuthorizeDapp;

  const factory RemoteRequest.signPayloads({required SignPayloadsRequest request}) = SignPayloads;

  const factory RemoteRequest.signTransactionsForSending({
    required SignAndSendTransactionsRequest request,
  }) = SignTransactionsForSending;

  const factory RemoteRequest.sendTransactions({
    required SignAndSendTransactionsRequest request,
    required List<Uint8List> signatures,
    required List<Uint8List> signedTransactions,
  }) = SendTransactions;
}

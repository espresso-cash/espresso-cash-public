part of 'bloc.dart';

@freezed
sealed class MobileWalletState with _$MobileWalletState {
  const factory MobileWalletState.none() = MobileWalletStateNone;
  const factory MobileWalletState.sessionTerminated() = MobileWalletStateSessionTerminated;
  const factory MobileWalletState.remote(RemoteRequest request) = MobileWalletStateRemote;
}

@freezed
sealed class RemoteRequest with _$RemoteRequest {
  const factory RemoteRequest.authorizeDapp({required AuthorizeRequest request}) =
      RemoteRequestAuthorizeDapp;

  const factory RemoteRequest.signPayloads({required SignPayloadsRequest request}) =
      RemoteRequestSignPayloads;

  const factory RemoteRequest.signTransactionsForSending({
    required SignAndSendTransactionsRequest request,
  }) = RemoteRequestSignTransactionsForSending;

  const factory RemoteRequest.sendTransactions({
    required SignAndSendTransactionsRequest request,
    required List<Uint8List> signatures,
    required List<Uint8List> signedTransactions,
  }) = RemoteRequestSendTransactions;
}

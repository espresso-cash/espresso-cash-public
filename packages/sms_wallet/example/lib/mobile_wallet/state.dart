part of 'bloc.dart';

@freezed
class MobileWalletState with _$MobileWalletState {
  const factory MobileWalletState.none() = None;
  const factory MobileWalletState.sessionTerminated() = SessionTerminated;
  const factory MobileWalletState.remote(RemoteRequest request) = Remote;
}

@freezed
class RemoteRequest with _$RemoteRequest {
  const factory RemoteRequest.authorizeDapp({
    required AuthorizeRequest request,
  }) = AuthorizeDapp;
}

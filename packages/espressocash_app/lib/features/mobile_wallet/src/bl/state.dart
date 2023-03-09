part of 'bloc.dart';

@freezed
class MobileWalletState with _$MobileWalletState {
  const factory MobileWalletState.requested(RemoteRequest request) = _Requested;
  const factory MobileWalletState.result(Object? result) = _Result;
}

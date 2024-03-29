import 'package:freezed_annotation/freezed_annotation.dart';

import 'remote_request.dart';

part 'notification.freezed.dart';

@freezed
class MobileWalletNotification with _$MobileWalletNotification {
  const factory MobileWalletNotification.initialized() = _Initialized;

  const factory MobileWalletNotification.sessionTerminated() =
      _SessionTerminated;

  const factory MobileWalletNotification.deauthorized() = _Deauthorized;

  const factory MobileWalletNotification.request(RemoteRequest request) =
      _RemoteRequsest;
}

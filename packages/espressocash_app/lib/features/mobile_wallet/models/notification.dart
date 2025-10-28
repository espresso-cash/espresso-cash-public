import 'package:freezed_annotation/freezed_annotation.dart';

import 'remote_request.dart';

part 'notification.freezed.dart';

@freezed
sealed class MobileWalletNotification with _$MobileWalletNotification {
  const factory MobileWalletNotification.initialized() = Initialized;

  const factory MobileWalletNotification.sessionTerminated() = SessionTerminated;

  const factory MobileWalletNotification.deauthorized() = Deauthorized;

  const factory MobileWalletNotification.request(RemoteRequest request) = RemoteRequsest;
}

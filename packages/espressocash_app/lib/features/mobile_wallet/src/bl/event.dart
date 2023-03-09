part of 'bloc.dart';

@freezed
class MobileWalletEvent with _$MobileWalletEvent {
  const factory MobileWalletEvent.declined() = _Decline;
  const factory MobileWalletEvent.accepted() = _Accepted;
}

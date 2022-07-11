part of 'balances_bloc.dart';

@freezed
class BalancesEvent with _$BalancesEvent {
  const factory BalancesEvent.requested({
    required String address,
  }) = BalancesEventRequested;
}

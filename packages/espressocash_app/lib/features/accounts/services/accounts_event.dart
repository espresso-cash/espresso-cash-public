part of 'accounts_bloc.dart';

@freezed
class AccountsEvent with _$AccountsEvent {
  const AccountsEvent._();

  const factory AccountsEvent.initialize() = Initialize;

  const factory AccountsEvent.created({
    required MyAccount account,
    required AccountSource source,
  }) = Created;

  const factory AccountsEvent.loggedOut() = LoggedOut;
}

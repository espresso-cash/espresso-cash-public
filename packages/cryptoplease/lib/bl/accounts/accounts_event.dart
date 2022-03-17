part of 'accounts_bloc.dart';

@freezed
class AccountsEvent with _$AccountsEvent {
  const AccountsEvent._();

  const factory AccountsEvent.initialize() = Initialize;

  const factory AccountsEvent.created({
    required MyAccount account,
    required String mnemonic,
  }) = Created;

  const factory AccountsEvent.profileUpdated({
    required String name,
    File? photo,
  }) = ProfileUpdated;

  const factory AccountsEvent.loggedOut() = LoggedOut;
}

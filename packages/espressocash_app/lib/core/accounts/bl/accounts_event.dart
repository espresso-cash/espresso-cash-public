part of 'accounts_bloc.dart';

@freezed
class AccountsEvent with _$AccountsEvent {
  const AccountsEvent._();

  const factory AccountsEvent.initialize() = Initialize;

  const factory AccountsEvent.created({
    required MyAccount account,
    required AccountSource source,
    @Default(false) bool hasFinishedOnboarding,
  }) = Created;

  const factory AccountsEvent.profileUpdated({
    required String name,
    File? photo,
    String? country,
  }) = ProfileUpdated;

  const factory AccountsEvent.loggedOut() = LoggedOut;
}

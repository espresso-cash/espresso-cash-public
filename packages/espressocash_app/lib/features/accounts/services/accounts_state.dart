part of 'accounts_bloc.dart';

@freezed
class AccountsState with _$AccountsState {
  const factory AccountsState({
    MyAccount? account,
    @Default(false) bool isProcessing,
  }) = _AccountsState;
}

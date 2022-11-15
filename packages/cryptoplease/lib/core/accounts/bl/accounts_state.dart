part of 'accounts_bloc.dart';

@freezed
class AccountsState with _$AccountsState {
  const factory AccountsState({
    MyAccount? account,
    AccessMode? accessMode,
    @Default(false) bool isProcessing,
  }) = _AccountsState;
}

@freezed
class AccessMode with _$AccessMode {
  const factory AccessMode.loaded() = _Loaded;
  const factory AccessMode.seedInputted() = _SeedInputted;
  const factory AccessMode.created() = _AccountCreated;
}

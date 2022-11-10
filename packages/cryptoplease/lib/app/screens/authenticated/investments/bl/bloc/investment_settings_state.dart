part of 'investment_settings_bloc.dart';

@freezed
class InvestmentSettingsState with _$InvestmentSettingsState {
  const factory InvestmentSettingsState.settings({
    @Default(false) bool hideZeroBalances,
  }) = InvestmentSettings;
}

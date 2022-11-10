part of 'investment_settings_bloc.dart';

@freezed
class InvestmentSettingsEvent with _$InvestmentSettingsEvent {
  const factory InvestmentSettingsEvent.init() = InvestmentSettingsInit;
  const factory InvestmentSettingsEvent.toggledZeroBalance() =
      SettingsToggleBalance;
}

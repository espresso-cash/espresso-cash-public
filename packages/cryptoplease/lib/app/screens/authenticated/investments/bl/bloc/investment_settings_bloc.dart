import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'investment_settings_bloc.freezed.dart';
part 'investment_settings_event.dart';

typedef _Emitter = Emitter<InvestmentSettingsState>;

@injectable
class InvestmentSettingsBloc
    extends Bloc<InvestmentSettingsEvent, InvestmentSettingsState> {
  InvestmentSettingsBloc(this._sharedPreferences)
      : super(const InvestmentSettings()) {
    on<InvestmentSettingsEvent>(_eventHandler);
  }

  final SharedPreferences _sharedPreferences;

  EventHandler<InvestmentSettingsEvent, InvestmentSettingsState>
      get _eventHandler => (event, emit) => event.map(
            init: (_) => _onInit(emit),
            toggledZeroBalance: (_) => _onToggleZeroBalances(emit),
          );

  Future<void> _onInit(_Emitter emit) async {
    final hideZeroBalanceToggle =
        _sharedPreferences.getBool(_hideBalanceKey) ?? false;

    emit(InvestmentSettings(hideZeroBalances: hideZeroBalanceToggle));
  }

  Future<void> _onToggleZeroBalances(_Emitter emit) async {
    final hideZeroBalanceToggle =
        _sharedPreferences.getBool(_hideBalanceKey) ?? false;

    await _sharedPreferences.setBool(_hideBalanceKey, !hideZeroBalanceToggle);

    emit(state.copyWith(hideZeroBalances: !hideZeroBalanceToggle));
  }
}

@freezed
class InvestmentSettingsState with _$InvestmentSettingsState {
  const factory InvestmentSettingsState.settings({
    @Default(false) bool hideZeroBalances,
  }) = InvestmentSettings;
}

const _hideBalanceKey = 'hideBalanceKey';

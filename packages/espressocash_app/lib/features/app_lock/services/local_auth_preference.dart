import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_auth_preference.freezed.dart';

@freezed
class LocalAuthPreference with _$LocalAuthPreference {
  const factory LocalAuthPreference.disabled() = _Disabled;
  const factory LocalAuthPreference.enabled() = _Enabled;
  const factory LocalAuthPreference.neverAsked() = _NeverAsked;
}

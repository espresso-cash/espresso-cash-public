import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../models/kyc_user_info.dart';

part 'state.freezed.dart';

@freezed
class KycState with _$KycState {
  const factory KycState({
    KycUserInfo? user,
    @Default(ValidationStatus.unverified) ValidationStatus kycStatus,
    @Default(ValidationStatus.unverified) ValidationStatus phoneStatus,
    @Default(ValidationStatus.unverified) ValidationStatus emailStatus,
  }) = _KycState;
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/kyc_model.dart';

part 'state.freezed.dart';

@freezed
class KycState with _$KycState {
  const factory KycState({
    KycUserInfo? user,
    @Default(false) bool hasPassedKyc,
    @Default(false) bool hasValidatedPhone,
    @Default(false) bool hasValidatedEmail,
  }) = _KycState;
}

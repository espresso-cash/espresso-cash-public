import 'package:freezed_annotation/freezed_annotation.dart';

import '../../currency/models/amount.dart';

part 'recovery_state.freezed.dart';

@freezed
class StellarRecoveryState with _$StellarRecoveryState {
  const factory StellarRecoveryState.none() = RecoveryNone;
  const factory StellarRecoveryState.pending({
    required CryptoAmount amount,
  }) = RecoveryPending;
  const factory StellarRecoveryState.processing({
    CryptoAmount? amount,
    String? txId,
  }) = RecoveryProcessing;
  const factory StellarRecoveryState.completed({
    required CryptoAmount amount,
    required String txId,
  }) = RecoveryCompleted;
  const factory StellarRecoveryState.failed() = RecoveryFailed;
  const factory StellarRecoveryState.dismissed() = RecoveryDismissed;
}

extension StellarRecoveryStateX on StellarRecoveryState {
  CryptoAmount? get amount => mapOrNull(
        pending: (e) => e.amount,
        processing: (e) => e.amount,
        completed: (e) => e.amount,
      );
}

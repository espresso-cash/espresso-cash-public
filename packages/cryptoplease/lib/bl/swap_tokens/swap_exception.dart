import 'package:cryptoplease/bl/amount.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap_exception.freezed.dart';

@freezed
class SwapException with _$SwapException implements Exception {
  const factory SwapException.routeNotFound() = RouteNotFound;

  const factory SwapException.setupFailed(Exception e) = SetupFailed;

  const factory SwapException.swapFailed(Exception e) = SwapFailed;

  const factory SwapException.cleanupFailed(Exception e) = CleanupFailed;

  const factory SwapException.insufficientBalance({
    required CryptoAmount balance,
    required CryptoAmount amount,
  }) = InsufficientBalance;

  const factory SwapException.insufficientFee({
    required CryptoAmount fee,
  }) = InsufficientFee;

  const factory SwapException.other(Exception e) = OtherError;
}

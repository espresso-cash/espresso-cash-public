import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/features/swap/bl/swap_transaction_set.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap_exception.freezed.dart';

@freezed
class SwapException with _$SwapException implements Exception {
  const factory SwapException.routeNotFound() = RouteNotFound;

  const factory SwapException.setupFailed(
    SwapTransactionSet txSet,
    Exception e,
  ) = SetupFailed;

  const factory SwapException.swapFailed(
    SwapTransactionSet txSet,
    Exception e,
  ) = SwapFailed;

  const factory SwapException.cleanupFailed(
    SwapTransactionSet txSet,
    Exception e,
  ) = CleanupFailed;

  const factory SwapException.insufficientBalance({
    required CryptoAmount balance,
    required CryptoAmount amount,
  }) = InsufficientBalance;

  const factory SwapException.insufficientFee({
    required CryptoAmount fee,
  }) = InsufficientFee;

  const factory SwapException.other(Exception e) = OtherError;
}

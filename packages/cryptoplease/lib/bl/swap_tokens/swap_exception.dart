import 'package:cryptoplease/bl/amount.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';

part 'swap_exception.freezed.dart';

@freezed
class SwapException with _$SwapException implements Exception {
  const factory SwapException.routeNotFound() = RouteNotFound;

  const factory SwapException.setupFailed(
    JupiterSwapTransactions tx,
    Exception e,
  ) = SetupFailed;

  const factory SwapException.swapFailed(
    JupiterSwapTransactions tx,
    Exception e,
  ) = SwapFailed;

  const factory SwapException.cleanupFailed(
    JupiterSwapTransactions tx,
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

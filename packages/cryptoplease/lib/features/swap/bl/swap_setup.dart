import 'package:cryptoplease/core/tokens/token.dart';
import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap_setup.freezed.dart';

@freezed
class SwapSetup with _$SwapSetup {
  const factory SwapSetup({
    required Token inputToken,
    required Token outputToken,
    required Decimal slippage,
  }) = _SwapSetup;
}

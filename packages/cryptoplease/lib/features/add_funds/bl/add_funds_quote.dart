import 'package:cryptoplease/core/amount.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_funds_quote.freezed.dart';

@freezed
class AddFundsQuote {
  const factory AddFundsQuote({
    required CryptoAmount buyAmount,
    FiatAmount? quotePrice,
    FiatAmount? minAmount,
    FiatAmount? feeAmount,
  }) = _AddFundsQuote;

  const AddFundsQuote._();
}

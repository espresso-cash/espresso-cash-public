import '../../../../core/amount.dart';
import '../../../../core/currency.dart';

/// Maximum fee to pay for the direct outgoing payment, 0.10 USDC.
const CryptoAmount maxFee =
    CryptoAmount(value: 100000, cryptoCurrency: Currency.usdc);

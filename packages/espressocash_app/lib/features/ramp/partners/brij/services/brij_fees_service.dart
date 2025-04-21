import 'package:async/async.dart';
import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';

import '../../../../accounts/auth_scope.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../kyc_sharing/services/kyc_service.dart';
import '../../../../ramp_partner/models/ramp_type.dart' as ec;

typedef BrijScalexFees = ({Amount receiveAmount, double rate, Amount totalFee});

@Singleton(scope: authScope)
class BrijFeesService {
  BrijFeesService(this._kycService);

  final KycSharingService _kycService;
  final _cache = AsyncCache<BrijScalexFees>(const Duration(seconds: 30));

  Amount? _lastAmount;
  ec.RampType? _lastType;

  Future<BrijScalexFees> fetchFees({
    required Amount amount,
    required ec.RampType type,
    required String partnerPK,
    required String walletPK,
    required String fiatCurrency,
  }) {
    if (amount != _lastAmount || type != _lastType) {
      _lastAmount = amount;
      _lastType = type;

      _cache.invalidate();
    }

    return _cache.fetch(
      () => _fetchFeesFromApi(
        amount: amount,
        type: type,
        partnerPK: partnerPK,
        walletPK: walletPK,
        fiatCurrency: fiatCurrency,
      ),
    );
  }

  Future<double> fetchRate({
    required ec.RampType type,
    required String partnerPK,
    required String walletPK,
    required String fiatCurrency,
  }) async {
    final referenceAmount = Amount.fromDecimal(value: Decimal.one, currency: Currency.usdc);

    final quote = await _kycService.getQuote(
      partnerPK: partnerPK,
      walletPK: walletPK,
      fiatCurrency: fiatCurrency,
      cryptoAmount: referenceAmount.decimal.toDouble(),
      rampType: type.toKycType(),
    );

    return quote.conversionRate;
  }

  Future<BrijScalexFees> _fetchFeesFromApi({
    required Amount amount,
    required ec.RampType type,
    required String partnerPK,
    required String walletPK,
    required String fiatCurrency,
  }) async {
    final quote = await _kycService.getQuote(
      partnerPK: partnerPK,
      walletPK: walletPK,
      fiatCurrency: fiatCurrency,
      cryptoAmount: amount.decimal.toDouble(),
      rampType: type.toKycType(),
    );

    final currency = currencyFromString(quote.fiatCurrency);

    final receiveAmount = Amount.fromDecimal(
      value: Decimal.parse(quote.fiatAmount.toString()),
      currency: currency,
    );

    final platformFee =
        quote.platformFee.fixedFee + quote.platformFee.percentageFee * amount.decimal.toDouble();
    final walletFee =
        quote.walletFee.fixedFee + quote.walletFee.percentageFee * amount.decimal.toDouble();
    final partnerFee =
        quote.partnerFee.fixedFee + quote.partnerFee.percentageFee * amount.decimal.toDouble();

    final totalFee = Amount.fromDecimal(
      value:
          Decimal.parse(platformFee.toString()) +
          Decimal.parse(walletFee.toString()) +
          Decimal.parse(partnerFee.toString()),
      currency: Currency.usdc,
    );

    return (receiveAmount: receiveAmount, rate: quote.conversionRate, totalFee: totalFee);
  }
}

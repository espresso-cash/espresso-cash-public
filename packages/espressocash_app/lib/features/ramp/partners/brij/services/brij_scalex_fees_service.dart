import 'package:async/async.dart';
import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';

import '../../../../accounts/auth_scope.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_type.dart';

typedef BrijScalexFees = ({Amount receiveAmount, double rate, Amount totalFee});

@Singleton(scope: authScope)
class BrijScalexFeesService {
  BrijScalexFeesService();

  final _cache = AsyncCache<BrijScalexFees>(const Duration(seconds: 30));

  Amount? _lastAmount;
  RampType? _lastType;

  Future<BrijScalexFees> fetchFees({
    required Amount amount,
    required RampType type,
  }) {
    if (amount != _lastAmount || type != _lastType) {
      _cache.invalidate();
      _lastAmount = amount;
      _lastType = type;
    }

    return _cache.fetch(() => _fetchFeesFromApi(amount: amount, type: type));
  }

  double fetchRate(RampType type) => switch (type) {
    RampType.onRamp => 1500.00,
    RampType.offRamp => 1480.00,
  };

  Future<BrijScalexFees> _fetchFeesFromApi({
    required Amount amount,
    required RampType type,
  }) {
    final rate = fetchRate(type);

    final totalFee = Amount.fromDecimal(
      value: Decimal.parse('1'),
      currency: Currency.usdc,
    );

    final decimalRate = Decimal.parse(rate.toString());

    final receiveAmount = switch (type) {
      RampType.onRamp => Amount.fromDecimal(
        value:
            (amount.decimal / decimalRate).toDecimal(
              scaleOnInfinitePrecision: 6,
            ) -
            Decimal.one,
        currency: Currency.usdc,
      ),
      RampType.offRamp => Amount.fromDecimal(
        value: (amount.decimal * decimalRate) - Decimal.one,
        currency: Currency.ngn,
      ),
    };

    return Future.value((
      receiveAmount: receiveAmount,
      rate: rate,
      totalFee: totalFee,
    ));
  }
}

import 'package:async/async.dart';
import 'package:decimal/decimal.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../accounts/auth_scope.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_type.dart';

typedef BrijScalexFees = ({
  Amount receiveAmount,
  double rate,
  Amount totalFee,
});

@Singleton(scope: authScope)
class BrijScalexFeesService {
  BrijScalexFeesService(this._client);

  final EspressoCashClient _client;
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

  Future<double> fetchRate(RampType type) async {
    final response = await _client.fetchScalexBrijFees(
      ScalexBrijFeeRequestDto(
        amount: '1',
        type: type.toDto(),
      ),
    );

    return response.rate;
  }

  Future<BrijScalexFees> _fetchFeesFromApi({
    required Amount amount,
    required RampType type,
  }) async {
    final response = await _client.fetchScalexBrijFees(
      ScalexBrijFeeRequestDto(
        amount: amount.decimal.toString(),
        type: type.toDto(),
      ),
    );

    final totalFee = Amount.fromDecimal(
      value: Decimal.parse(response.scalexFees.totalFee.toString()),
      currency: Currency
          .usdc, //TODO, might be different depending on the ramp type, withdraw could be in NGN
    );

    final receiveAmount = switch (type) {
      RampType.onRamp => Amount.fromDecimal(
          value: Decimal.parse(response.cryptoAmount.toString()),
          currency: Currency.usdc,
        ),
      RampType.offRamp => Amount.fromDecimal(
          value: Decimal.parse(response.fiatAmount.toString()),
          currency: Currency.ngn,
        ),
    };

    return (
      receiveAmount: receiveAmount,
      rate: response.rate,
      totalFee: totalFee,
    );
  }
}

extension on RampType {
  RampTypeDto toDto() => switch (this) {
        RampType.onRamp => RampTypeDto.onRamp,
        RampType.offRamp => RampTypeDto.offRamp
      };
}

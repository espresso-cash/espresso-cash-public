import 'package:async/async.dart';
import 'package:decimal/decimal.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../accounts/auth_scope.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../models/ramp_type.dart';

typedef MoneygramFees = ({
  Amount receiveAmount,
  Amount moneygramFee,
  Amount bridgeFee,
  Amount gasFeeInUsdc,
  int? priorityFee,
});

@Singleton(scope: authScope)
class MoneygramFeesService {
  MoneygramFeesService(this._client);

  final EspressoCashClient _client;
  final _cache = AsyncCache<MoneygramFees>(const Duration(seconds: 30));

  Amount? _lastAmount;
  RampType? _lastType;

  Future<MoneygramFees> fetchFees({
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

  Future<MoneygramFees> _fetchFeesFromApi({
    required Amount amount,
    required RampType type,
  }) async {
    final fee = await _client.calculateMoneygramFee(
      MoneygramFeeRequestDto(
        type: type.toDto(),
        amount: amount.decimal.toString(),
      ),
    );

    return (
      receiveAmount: Amount.fromDecimal(
        value: Decimal.parse(fee.totalAmount),
        currency: switch (type) {
          RampType.onRamp => Currency.usdc,
          RampType.offRamp => Currency.usd
        },
      ),
      moneygramFee: Amount.fromDecimal(
        value: Decimal.parse(fee.moneygramFee),
        currency: Currency.usdc,
      ),
      bridgeFee: Amount.fromDecimal(
        value: Decimal.parse(fee.bridgeFee),
        currency: Currency.usdc,
      ),
      gasFeeInUsdc: Amount.fromDecimal(
        value: Decimal.parse(fee.gasFeeInUsdc ?? '0'),
        currency: Currency.usdc,
      ),
      priorityFee: fee.priorityFee,
    );
  }
}

extension on RampType {
  RampTypeDto toDto() => switch (this) {
        RampType.onRamp => RampTypeDto.onRamp,
        RampType.offRamp => RampTypeDto.offRamp
      };
}

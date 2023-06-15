import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../../core/accounts/bl/account.dart';
import '../../../core/amount.dart';
import '../../../core/analytics/analytics_manager.dart';
import '../../../core/currency.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../models/off_ramp_payment.dart';
import '../src/bl/orp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createORP({
    required Decimal amountInUsdc,
    required Ed25519HDPublicKey receiver,
  }) async =>
      runWithLoader(this, () async {
        const currency = Currency.usdc;
        final payment = await sl<ORPService>().create(
          account: read<MyAccount>().wallet,
          amount: CryptoAmount(
            value: currency.decimalToInt(amountInUsdc),
            cryptoCurrency: currency,
          ),
          receiver: receiver,
        );

        sl<AnalyticsManager>().offRampPaymentCreated();

        return payment.id;
      });

  Future<void> retryORP({required OffRampPayment payment}) async =>
      runWithLoader(this, () async {
        await sl<ORPService>().retry(
          payment,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().offRampPaymentCreated();
      });
}

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../../analytics/analytics_manager.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../services/odp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createODP({
    required Decimal amountInUsdc,
    required Ed25519HDPublicKey receiver,
    required Ed25519HDPublicKey? reference,
  }) =>
      runWithLoader(this, () async {
        const currency = Currency.usdc;
        final payment = await sl<ODPService>().create(
          account: sl<MyAccount>().wallet,
          amount: CryptoAmount(
            value: currency.decimalToInt(amountInUsdc),
            cryptoCurrency: currency,
          ),
          receiver: receiver,
          reference: reference,
        );

        sl<AnalyticsManager>().directPaymentCreated();

        return payment.id;
      });

  Future<void> retryODP({required String paymentId}) =>
      runWithLoader(this, () async {
        await sl<ODPService>().retry(
          paymentId,
          account: sl<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().directPaymentCreated();
      });

  Future<void> cancelODP({required String paymentId}) =>
      runWithLoader(this, () async {
        await sl<ODPService>().cancel(paymentId);
        Navigator.pop(this);

        sl<AnalyticsManager>().directPaymentCancelled();
      });
}

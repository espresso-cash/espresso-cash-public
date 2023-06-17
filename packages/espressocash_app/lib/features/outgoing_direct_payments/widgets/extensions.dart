import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../../core/amount.dart';
import '../../../core/analytics/analytics_manager.dart';
import '../../../core/currency.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../models/outgoing_direct_payment.dart';
import '../services/odp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createODP({
    required Decimal amountInUsdc,
    required Ed25519HDPublicKey receiver,
    required Ed25519HDPublicKey? reference,
  }) async =>
      runWithLoader(this, () async {
        const currency = Currency.usdc;
        final payment = await sl<ODPService>().create(
          account: read<MyAccount>().wallet,
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

  Future<void> retryODP({required OutgoingDirectPayment payment}) async =>
      runWithLoader(this, () async {
        await sl<ODPService>().retry(
          payment,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().directPaymentCreated();
      });
}

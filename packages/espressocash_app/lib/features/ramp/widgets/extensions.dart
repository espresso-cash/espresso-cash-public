import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../core/amount.dart';
import '../../../core/analytics/analytics_manager.dart';
import '../../../core/currency.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../models/off_ramp_payment.dart';
import '../services/orp_service.dart';

extension BuildContextExt on BuildContext {
  //TODO create methods for transfer and sign
  Future<String> createORP({
    required Decimal amountInUsdc,
    required Ed25519HDPublicKey receiver,
  }) async =>
      runWithLoader(this, () async {
        const currency = Currency.usdc;
        final payment = await sl<ORPService>().createTransfer(
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

  Future<String> createORPSigned({
    required SignedTx tx,
  }) async =>
      runWithLoader(this, () async {
        final payment = await sl<ORPService>().createSigned(
          account: read<MyAccount>().wallet,
          tx: tx,
        );

        sl<AnalyticsManager>().offRampPaymentCreated();

        return payment.id;
      });

  Future<void> retryORP({required ORPTransferFunds payment}) async =>
      runWithLoader(this, () async {
        await sl<ORPService>().retryTransfer(
          payment,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().offRampPaymentCreated();
      });
}

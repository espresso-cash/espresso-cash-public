import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import '../../../core/amount.dart';
import '../../../core/analytics/analytics_manager.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../models/off_ramp_payment.dart';
import '../services/orp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createORP({
    required SignedTx tx,
    required String provider,
    required CryptoAmount amount,
  }) async =>
      runWithLoader(this, () async {
        final payment = await sl<ORPService>().createORP(
          account: read<MyAccount>().wallet,
          tx: tx,
          provider: provider,
          amount: amount,
        );

        sl<AnalyticsManager>().offRampPaymentCreated();

        return payment.id;
      });

  Future<void> retryORP({
    required OffRampPayment payment,
    required SignedTx tx,
  }) async =>
      runWithLoader(this, () async {
        await sl<ORPService>().retryORP(
          payment,
          tx: tx,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().offRampPaymentCreated();
      });
}

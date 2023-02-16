import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

import '../../../core/accounts/bl/account.dart';
import '../../../core/amount.dart';
import '../../../core/analytics/analytics_manager.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../models/outgoing_direct_payment.dart';
import '../src/bl/odp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createODP({
    required CryptoAmount amount,
    required Ed25519HDPublicKey receiver,
    required Ed25519HDPublicKey? reference,
  }) async =>
      runWithLoader(this, () async {
        final payment = await sl<ODPService>().create(
          account: read<MyAccount>().wallet,
          amount: amount,
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

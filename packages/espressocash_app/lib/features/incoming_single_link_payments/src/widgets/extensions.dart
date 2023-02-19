import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../core/analytics/analytics_manager.dart';
import '../../../../core/single_key_payments.dart';
import '../../../../di.dart';
import '../../../../ui/loader.dart';
import '../bl/ilsp_service.dart';
import '../bl/islp_payment.dart';

extension ISLPExt on BuildContext {
  Future<String> createISLP(SingleKeyPaymentData skpData) async =>
      runWithLoader(this, () async {
        final escrow = await _walletFromKey(encodedKey: skpData.key);

        sl<AnalyticsManager>().singleLinkReceived();

        final payment = await sl<ISLPService>().create(
          account: read<MyAccount>().wallet,
          escrowAccount: escrow,
        );

        return payment.id;
      });

  Future<void> retryISLP(IncomingSingleLinkPayment payment) async =>
      runWithLoader(this, () async {
        await sl<ISLPService>().retry(
          payment,
          account: read<MyAccount>().wallet,
        );
      });
}

Future<Wallet> _walletFromKey({
  required String encodedKey,
}) async {
  final key = ByteArray.fromBase58(encodedKey).toList();

  return Wallet.fromPrivateKeyBytes(privateKey: key);
}

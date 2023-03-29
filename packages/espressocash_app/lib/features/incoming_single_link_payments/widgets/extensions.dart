import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../core/accounts/bl/account.dart';
import '../../../core/analytics/analytics_manager.dart';
import '../../../core/split_key_payments.dart';
import '../../../di.dart';
import '../src/bl/ilsp_service.dart';
import '../src/bl/islp_payment.dart';

extension ISLPExt on BuildContext {
  Future<String> createISLP({
    required SplitKeyFirstLink first,
    required SplitKeySecondLink second,
  }) async {
    final escrow = await walletFromParts(
      firstPart: first.key,
      secondPart: second.key,
    );

    sl<AnalyticsManager>().singleLinkReceived();

    final payment = await sl<ISLPService>().create(
      account: read<MyAccount>().wallet,
      escrowAccount: escrow,
    );

    return payment.id;
  }

  Future<void> retryISLP(IncomingSingleLinkPayment payment) async {
    await sl<ISLPService>().retry(
      payment,
      account: read<MyAccount>().wallet,
    );
  }
}

Future<Wallet> walletFromParts({
  required String firstPart,
  required String secondPart,
}) async {
  final keyPart1 = ByteArray.fromBase58(firstPart).toList();
  final keyPart2 = ByteArray.fromBase58(secondPart).toList();

  return Wallet.fromPrivateKeyBytes(privateKey: keyPart1 + keyPart2);
}

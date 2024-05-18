import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
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

        return payment.id;
      });

  Future<void> retryODP({required String paymentId}) =>
      runWithLoader(this, () async {
        await sl<ODPService>().retry(
          paymentId,
          account: sl<MyAccount>().wallet,
        );
      });

  Future<void> cancelODP({required String paymentId}) =>
      runWithLoader(this, () async {
        await sl<ODPService>().cancel(paymentId);
        Navigator.pop(this);
      });

  Future<bool> isSolanaPayRequestPaid({required SolanaPayRequest request}) =>
      runWithLoader(this, () async {
        final client = sl<SolanaClient>();

        final reference = request.reference?.firstOrNull;

        if (reference == null) {
          return false;
        }

        final signature = await client.findSolanaPayTransaction(
          reference: reference,
          commitment: Commitment.confirmed,
        );

        if (signature == null) {
          return false;
        }

        try {
          await client.validateSolanaPayTransaction(
            signature: signature,
            recipient: request.recipient,
            splToken: request.splToken,
            reference: request.reference,
            amount: request.amount ?? Decimal.zero,
            commitment: Commitment.confirmed,
          );

          return true;
        } on Exception {
          return false;
        }
      });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/amount.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../services/payment_request_service.dart';

extension PaymentRequestExt on BuildContext {
  Future<String> createPayRequest({
    required CryptoAmount tokenAmount,
  }) =>
      runWithLoader(this, () async {
        final recipient = read<MyAccount>().wallet.publicKey;

        final payment = await sl<PaymentRequestService>().create(
          recipient: recipient,
          tokenAmount: tokenAmount,
        );

        return payment.id;
      });
}

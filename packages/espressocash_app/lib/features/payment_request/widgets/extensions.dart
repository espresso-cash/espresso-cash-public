import 'package:dfunc/dfunc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../../currency/amount.dart';
import '../../profile/data/profile_repository.dart';
import '../services/payment_request_service.dart';

extension PaymentRequestExt on BuildContext {
  Future<String> createPayRequest({
    required CryptoAmount tokenAmount,
  }) =>
      runWithLoader(this, () async {
        final recipient = read<MyAccount>().wallet.publicKey;
        final name =
            sl<ProfileRepository>().firstName.let((e) => e.isEmpty ? null : e);

        final payment = await sl<PaymentRequestService>().create(
          recipient: recipient,
          tokenAmount: tokenAmount,
          label: name,
        );

        return payment.id;
      });
}

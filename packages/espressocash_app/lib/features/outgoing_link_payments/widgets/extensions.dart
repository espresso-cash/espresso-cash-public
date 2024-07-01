import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../../currency/models/amount.dart';
import '../models/outgoing_link_payment.dart';
import '../services/olp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createOLP({required CryptoAmount amount}) =>
      runWithLoader(this, () async {
        final span = _start(function: 'createOLP');

        final payment = await sl<OLPService>().create(
          amount: amount,
          account: sl<MyAccount>().wallet,
        );
        await span.finish();

        return payment.id;
      });

  Future<void> cancelOLP({required OutgoingLinkPayment payment}) =>
      runWithLoader<void>(this, () async {
        final span = _start(function: 'cancelOLP');
        await sl<OLPService>().cancel(
          payment,
          account: sl<MyAccount>().wallet,
        );
        await span.finish();
      });

  Future<void> retryOLP({required OutgoingLinkPayment payment}) =>
      runWithLoader<void>(this, () async {
        final span = _start(function: 'retryOLP');
        await sl<OLPService>().retry(
          payment,
          account: sl<MyAccount>().wallet,
        );
        await span.finish();
      });
}

ISentrySpan _start({required String function}) => Sentry.startTransaction(
      'OLP Tx Creation',
      function,
    );

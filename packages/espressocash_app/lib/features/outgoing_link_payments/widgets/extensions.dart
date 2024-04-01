import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../../analytics/analytics_manager.dart';
import '../../currency/amount.dart';
import '../models/outgoing_link_payment.dart';
import '../services/olp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createOLP({required CryptoAmount amount}) =>
      runWithLoader(this, () async {
        final payment = await sl<OLPService>().create(
          amount: amount,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().linksCreated();

        return payment.id;
      });

  Future<void> cancelOLP({required OutgoingLinkPayment payment}) =>
      runWithLoader<void>(this, () async {
        await sl<OLPService>().cancel(
          payment,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().linksCreated();
      });

  Future<void> retryOLP({required OutgoingLinkPayment payment}) =>
      runWithLoader<void>(this, () async {
        await sl<OLPService>().retry(
          payment,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().linksCreated();
      });
}

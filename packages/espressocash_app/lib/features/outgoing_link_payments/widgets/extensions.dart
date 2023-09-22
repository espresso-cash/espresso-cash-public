import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/amount.dart';
import '../../../core/analytics/analytics_manager.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../models/outgoing_link_payment.dart';
import '../services/olp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createOLP({required CryptoAmount amount}) async =>
      runWithLoader(this, () async {
        final payment = await sl<OLPService>().create(
          amount: amount,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().linksCreated();

        return payment.id;
      });

  Future<void> cancelOLP({required OutgoingLinkPayment payment}) async =>
      runWithLoader<void>(this, () async {
        await sl<OLPService>().cancel(
          payment,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().linksCreated();
      });

  Future<void> retryOLP({required OutgoingLinkPayment payment}) async =>
      runWithLoader<void>(this, () async {
        await sl<OLPService>().retry(
          payment,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().linksCreated();
      });
}

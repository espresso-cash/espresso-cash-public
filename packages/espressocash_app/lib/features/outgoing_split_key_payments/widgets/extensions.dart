import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/accounts/bl/account.dart';
import '../../../core/amount.dart';
import '../../../core/analytics/analytics_manager.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../models/outgoing_split_key_payment.dart';
import '../src/bl/oskp_service.dart';

extension BuildContextExt on BuildContext {
  Future<String> createOSKP({required CryptoAmount amount}) async =>
      runWithLoader(this, () async {
        final payment = await sl<OSKPService>().create(
          amount: amount,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().linksCreated();

        return payment.id;
      });

  Future<void> cancelOSKP({required OutgoingSplitKeyPayment payment}) async =>
      runWithLoader<void>(this, () async {
        await sl<OSKPService>().cancel(
          payment,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().linksCreated();
      });

  Future<void> retryOSKP({required OutgoingSplitKeyPayment payment}) async =>
      runWithLoader<void>(this, () async {
        await sl<OSKPService>().retry(
          payment,
          account: read<MyAccount>().wallet,
        );
        sl<AnalyticsManager>().linksCreated();
      });
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/amount.dart';
import '../../../routes.dart';

extension ReceiveFlowExt on BuildContext {
  void navigateToReceiveByLink({required CryptoAmount amount}) =>
      navigateTo(LinkRequestFlowRoute(initialAmount: amount));
}

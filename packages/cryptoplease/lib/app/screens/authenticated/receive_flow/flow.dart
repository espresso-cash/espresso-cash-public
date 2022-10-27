import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:flutter/material.dart';

extension ReceiveFlowExt on BuildContext {
  void navigateToReceiveByLink({required CryptoAmount amount}) =>
      navigateTo(LinkRequestFlowRoute(initialAmount: amount));
}

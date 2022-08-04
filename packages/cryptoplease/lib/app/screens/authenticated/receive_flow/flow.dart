import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:flutter/material.dart';

extension ReceiveFlowExt on BuildContext {
  void navigateToReceiveFlow({Token? token}) => navigateTo(
        RequestTypeRoute(
          onLinkSelected: () =>
              navigateTo(LinkRequestFlowRoute(initialToken: token)),
          onAddressSelected: () => navigateTo(const ShareAddressRoute()),
        ),
      );

  void navigateToReceiveByLink({CryptoAmount? amount}) => navigateTo(
        LinkRequestFlowRoute(
          initialToken: null,
          initialAmount: amount,
        ),
      );
}

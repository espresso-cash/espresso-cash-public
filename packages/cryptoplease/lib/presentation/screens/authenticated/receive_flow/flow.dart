import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:flutter/material.dart';

extension ReceiveFlowExt on BuildContext {
  void navigateToReceiveFlow({Token? token}) => navigateTo(
        RequestTypeRoute(
          onLinkSelected: () =>
              navigateTo(LinkRequestFlowRoute(initialToken: token)),
          onAddressSelected: () => navigateTo(const ShareAddressRoute()),
        ),
      );
}

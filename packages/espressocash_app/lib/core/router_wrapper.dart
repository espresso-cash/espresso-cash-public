import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

mixin RouterWrapper<T extends StatefulWidget> on State<T> {
  final routerKey = GlobalKey<AutoRouterState>();

  StackRouter? get router => routerKey.currentState?.controller;

  /// If not null, it will be pushed as the initial route after the first frame.
  @protected
  PageRouteInfo? get initialRoute => null;

  @override
  void initState() {
    super.initState();
    initialRoute?.let(
      (route) => WidgetsBinding.instance
          .addPostFrameCallback((_) => _pushInitialRoute(route)),
    );
  }

  void _pushInitialRoute(PageRouteInfo route) => router?.push(route);
}

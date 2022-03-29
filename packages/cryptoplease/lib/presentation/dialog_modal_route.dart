import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DialogModalRoute<T> extends CustomRoute<T> {
  const DialogModalRoute({
    required Type page,
    String? name,
    String? path,
    List<AutoRoute<dynamic>>? children,
    bool hasBarrier = true,
  }) : super(
          name: name,
          page: page,
          path: path,
          customRouteBuilder: hasBarrier
              ? dialogRouteBuilder
              : dialogRouteWithoutBarrierBuilder,
          children: children,
        );

  static Route<T> dialogRouteBuilder<T>(
    BuildContext context,
    Widget child,
    CustomPage<T> page,
  ) =>
      DialogRoute<T>(
        barrierDismissible: false,
        context: context,
        settings: page,
        builder: (context) => child,
      );

  static Route<T> dialogRouteWithoutBarrierBuilder<T>(
    BuildContext context,
    Widget child,
    CustomPage<T> page,
  ) =>
      DialogRoute<T>(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        settings: page,
        builder: (context) => child,
      );
}

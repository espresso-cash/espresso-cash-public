import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config.dart';
import '../../ui/web_view_screen.dart';

class PrivacyRoute extends GoRouteData {
  const PrivacyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      WebViewScreen(url: Uri.parse(privacyUrl));
}

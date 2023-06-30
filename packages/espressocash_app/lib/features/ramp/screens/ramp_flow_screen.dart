import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/router_wrapper.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../../ui/snackbar.dart';
import '../../profile/data/profile_repository.dart';
import '../models/ramp_type.dart';

@RoutePage()
class RampFlowScreen extends StatefulWidget {
  const RampFlowScreen({
    super.key,
    required this.type,
  });

  final RampType type;

  @override
  State<RampFlowScreen> createState() => _RampFlowScreenState();
}

class _RampFlowScreenState extends State<RampFlowScreen> with RouterWrapper {
  void _showSnackbar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCpSnackbar(context, message: 'Please setup your profile first.');
    });
  }

  PageRouteInfo _openProfileRoute() {
    _showSnackbar();

    return ManageProfileRoute(
      onSubmitted: () {
        context.router.pop();
        _handleRedirect();
      },
    );
  }

  PageRouteInfo _handleRedirect() {
    final profile = sl<ProfileRepository>().profile;

    return switch (widget.type) {
      // RampType.onRamp => {},
      // RampType.offRamp => {},
      _ => _openProfileRoute()
    };

    // return switch (widget.type) {
    //   case RampType.onRamp:
    //     onRampOnRamp(context);
    //     break;
    //   case RampType.offRamp:
    //     break;
    // }
    // }
  }

  @override
  PageRouteInfo get initialRoute {
    final profile = sl<ProfileRepository>().profile;

    return profile.country == null ? _openProfileRoute() : _handleRedirect();
  }

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}

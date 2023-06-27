import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/router_wrapper.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
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
  void _openProfileScreen() => router?.push(
        ManageProfileRoute(
          onSubmitted: _handleRedirect,
        ),
      );

  void _handleRedirect() {
    final profile = sl<ProfileRepository>().profile;

    print(profile.country);
  }

  @override
  void initState() {
    super.initState();

    final profile = sl<ProfileRepository>().profile;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profile.country != null) {
        _openProfileScreen();
      } else {
        _handleRedirect();
      }
    });
  }

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}

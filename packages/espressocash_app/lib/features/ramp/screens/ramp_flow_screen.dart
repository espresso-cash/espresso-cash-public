import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/router_wrapper.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/models/country.dart';
import '../../profile/models/profile.dart';
import '../models/ramp_providers.dart';
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
  void _saveCountry(Country country) {
    final profile = sl<ProfileRepository>().profile;

    sl<ProfileRepository>().profile = Profile(
      firstName: profile.firstName,
      photoPath: profile.photoPath,
      country: country.code,
    );
  }

  PageRouteInfo countrySelectorRoute() => CountryPickerRoute(
        onSubmitted: (country) {
          _saveCountry(country);

          router?.pop();
          router?.push(_handleRedirect());
        },
      );

  PageRouteInfo _handleRedirect() {
    const onRampProvider = OnRampProviders.rampNetwork;
    const offRampProvider = OffRampProviders.none;

    return switch (widget.type) {
      RampType.onRamp => switch (onRampProvider) {
          OnRampProviders.rampNetwork => const RampNetworkRampRoute(),
        },
      RampType.offRamp => switch (offRampProvider) {
          OffRampProviders.none => const ComingSoonRoute(),
        }
    };
  }

  @override
  PageRouteInfo get initialRoute {
    final profile = sl<ProfileRepository>().profile;

    return profile.country == null ? countrySelectorRoute() : _handleRedirect();
  }

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}

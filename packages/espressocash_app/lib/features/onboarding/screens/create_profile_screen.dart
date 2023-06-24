import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/widgets/create_profile.dart';

@RoutePage()
class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) => CreateProfile(
        onSubmitted: onDone,
        onBackButtonPressed: () => context.router.pop(),
        initial: sl<ProfileRepository>().profile,
      );
}

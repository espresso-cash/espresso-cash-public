import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../data/profile_repository.dart';
import '../widgets/create_profile.dart';

@RoutePage()
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => CreateProfile(
        onSubmitted: () => context.router.pop(),
        onBackButtonPressed: () => Navigator.pop(context),
        initial: sl<ProfileRepository>().profile,
      );
}

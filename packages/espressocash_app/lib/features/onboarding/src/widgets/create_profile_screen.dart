import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/create_profile.dart';
import '../bl/onboarding_bloc.dart';

@RoutePage()
class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => CreateProfile(
        onSubmitted: (name, photo) async {
          context
              .read<OnboardingBloc>()
              .add(OnboardingEvent.submitted(name: name, photo: photo));
        },
        onBackButtonPressed: () => context.router.pop(),
      );
}

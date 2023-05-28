import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../onboarding/widgets/create_profile.dart';
import '../bl/sign_in_bloc.dart';

class SignInProfileScreen extends StatelessWidget {
  const SignInProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => CreateProfile(
        onSubmitted: (name, photo) async {
          context
              .read<SignInBloc>()
              .add(SignInEvent.submitted(name: name, photo: photo));
        },
        onBackButtonPressed: () => context.router.pop(),
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile/widgets/create_profile.dart';
import '../services/sign_in_bloc.dart';

@RoutePage()
class SignInProfileScreen extends StatelessWidget {
  const SignInProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => CreateProfile(
        onSubmitted: () {
          context.read<SignInBloc>().add(const SignInEvent.submitted());
        },
        onBackButtonPressed: () => context.router.pop(),
      );
}

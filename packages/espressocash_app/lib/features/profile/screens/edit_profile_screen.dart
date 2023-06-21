import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../ui/loader.dart';
import '../../accounts/services/accounts_bloc.dart';
import '../../onboarding/widgets/create_profile.dart';

@RoutePage()
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AccountsBloc>().state.isProcessing;
    final state = context.read<AccountsBloc>().state;
    final profile = state.account?.profile;

    return BlocListener<AccountsBloc, AccountsState>(
      listenWhen: (s1, s2) => s1.isProcessing && !s2.isProcessing,
      listener: (_, __) => Navigator.pop(context),
      child: CpLoader(
        isLoading: isLoading,
        child: CreateProfile(
          onSubmitted: (name, photo, country) {
            context.read<AccountsBloc>().add(
                  ProfileUpdated(
                    name: name,
                    photo: photo,
                    country: country,
                  ),
                );
          },
          onBackButtonPressed: () => Navigator.pop(context),
          initial: profile,
        ),
      ),
    );
  }
}

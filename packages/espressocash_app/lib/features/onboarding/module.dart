import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../accounts/models/account.dart';
import 'data/onboarding_repository.dart';

class OnboardingModule extends SingleChildStatefulWidget {
  const OnboardingModule({
    super.key,
    super.child,
  });

  @override
  State<StatefulWidget> createState() => _OnboardingModuleState();
}

class _OnboardingModuleState extends SingleChildState<OnboardingModule> {
  @override
  void initState() {
    super.initState();

    final account = context.read<MyAccount>();
    if (account.accessMode == const AccessMode.seedInputted()) {
      sl<OnboardingRepository>().hasConfirmedPassphrase = true;
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      child ?? const SizedBox.shrink();
}

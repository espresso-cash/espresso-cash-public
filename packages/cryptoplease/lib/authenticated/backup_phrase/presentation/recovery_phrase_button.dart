import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/profile_button.dart';
import 'package:flutter/material.dart';

class RecoveryPhraseButton extends StatelessWidget {
  const RecoveryPhraseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProfileButton(
        label: context.l10n.viewRecoveryPhrase,
        onPressed: () => context.router.navigate(const BackupPhraseFlowRoute()),
      );
}

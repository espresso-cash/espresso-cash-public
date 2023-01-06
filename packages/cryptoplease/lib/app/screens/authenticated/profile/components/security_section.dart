import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../features/app_lock/module.dart';
import '../../../../../features/legal/flow.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import 'profile_button.dart';
import 'profile_section.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.securitySectionTitle,
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          const AppLockMenuItem(),
          ProfileButton(
            label: context.l10n.viewRecoveryPhrase,
            description: context.l10n.viewRecoveryPhraseDescription,
            onPressed: () => context.router.push(const BackupPhraseFlowRoute()),
          ),
          ProfileButton(
            label: context.l10n.termsOfUse,
            onPressed: () => context.navigateToTermsOfUse(),
          ),
          ProfileButton(
            label: context.l10n.privacyPolicy,
            onPressed: () => context.navigateToPrivacyPolicy(),
          ),
        ],
      );
}

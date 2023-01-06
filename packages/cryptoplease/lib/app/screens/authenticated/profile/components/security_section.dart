import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../features/app_lock/module.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import 'menu_button.dart';
import 'profile_section.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.securitySectionTitle,
        padding: const EdgeInsets.symmetric(vertical: 16),
        actions: [
          const AppLockMenuItem(),
          MenuButton(
            title: context.l10n.viewRecoveryPhrase,
            description: context.l10n.viewRecoveryPhraseDescription,
            icon: Assets.icons.secret,
            onTap: () => context.router.push(const BackupPhraseFlowRoute()),
          ),
        ],
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import 'menu_button.dart';
import 'profile_section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.learningSectionTitle,
        padding: const EdgeInsets.symmetric(vertical: 16),
        actions: [
          MenuButton(
            title: context.l10n.editProfile,
            description: context.l10n.editProfileDescription,
            icon: Assets.icons.visibility,
            onTap: () => context.router.push(const EditProfileRoute()),
          ),
          MenuButton(
            title: context.l10n.learnAboutCrypto,
            description: context.l10n.learnAboutCryptoDescription,
            icon: Assets.icons.info,
            onTap: () => context.router.push(const HelpRoute()),
          ),
        ],
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.gr.dart';
import 'package:cryptoplease/app/screens/authenticated/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/features/profile/components/menu_button.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Material(
          color: CpColors.greyBackground,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _Section(
                title: context.l10n.securitySectionTitle,
                children: [
                  MenuButton(
                    title: context.l10n.appLock,
                    description: context.l10n.appLockDescription,
                    icon: Assets.icons.lock,
                    onTap: () => context.router.push(
                      const AppLockSetupFlowRoute(),
                    ),
                  ),
                  MenuButton(
                    title: context.l10n.viewRecoveryPhrase,
                    description: context.l10n.viewRecoveryPhraseDescription,
                    icon: Assets.icons.secret,
                    onTap: () => context.router.push(
                      const BackupPhraseFlowRoute(),
                    ),
                  ),
                ],
              ),
              _Section(
                title: context.l10n.yourAccountSectionTitle,
                children: [
                  MenuButton(
                    title: context.l10n.editProfile,
                    description: context.l10n.editProfileDescription,
                    icon: Assets.icons.visibility,
                    onTap: () => context.router.push(
                      const EditProfileRoute(),
                    ),
                  ),
                  MenuButton(
                    title: context.l10n.learnAboutCrypto,
                    description: context.l10n.learnAboutCryptoDescription,
                    icon: Assets.icons.info,
                    onTap: () => context.router.push(
                      const HelpRoute(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: cpNavigationBarheight + 16)
            ],
          ),
        ),
      );
}

class _Section extends StatelessWidget {
  const _Section({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, bottom: 4),
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: CpColors.menuPrimaryTextColor,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Material(
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: children,
              ),
            ),
          ),
        ],
      );
}

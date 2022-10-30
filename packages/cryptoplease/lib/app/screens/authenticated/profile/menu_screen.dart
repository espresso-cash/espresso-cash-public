import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/balances/presentation/refresh_balance_wrapper.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/navigation_bar/navigation_bar.dart';
import '../../../../ui/theme.dart';
import 'components/menu_button.dart';
import 'components/menu_header.dart';
import 'components/menu_section.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => RefreshBalancesWrapper(
        builder: (context, onRefresh) => CpTheme.light(
          child: RefreshIndicator(
            displacement: 80,
            notificationPredicate: T,
            onRefresh: onRefresh,
            backgroundColor: Colors.white,
            color: CpColors.primaryColor,
            child: Container(
              height: double.infinity,
              decoration: _menuScreenBackground,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
                child: Column(
                  children: const [
                    MenuHeader(),
                    _SecuritySection(),
                    _AboutSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

const _menuScreenBackground = BoxDecoration(
  gradient: LinearGradient(
    stops: [0.5, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Colors.white,
      CpColors.lightGreyBackground,
    ],
  ),
);

class _SecuritySection extends StatelessWidget {
  const _SecuritySection();

  @override
  Widget build(BuildContext context) => MenuSection(
        title: context.l10n.securitySectionTitle,
        children: [
          MenuButton(
            title: context.l10n.appLock,
            description: context.l10n.appLockDescription,
            icon: Assets.icons.lock,
            onTap: () => context.router.push(const AppLockSetupFlowRoute()),
          ),
          MenuButton(
            title: context.l10n.viewRecoveryPhrase,
            description: context.l10n.viewRecoveryPhraseDescription,
            icon: Assets.icons.secret,
            onTap: () => context.router.push(const BackupPhraseFlowRoute()),
          ),
        ],
      );
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) => MenuSection(
        title: context.l10n.yourAccountSectionTitle,
        children: [
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

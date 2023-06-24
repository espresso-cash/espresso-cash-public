import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../features/app_lock/widgets/app_lock_menu_item.dart';
import '../../../../../features/legal/flow.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../accounts/services/accounts_bloc.dart';
import 'profile_button.dart';
import 'profile_section.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    final isSagaWallet = context.select<AccountsBloc, bool>(
      (bloc) => bloc.state.account?.wallet is SagaWallet,
    );

    return ProfileSection(
      title: context.l10n.securitySectionTitle,
      padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
      actions: [
        const AppLockMenuItem(),
        if (!isSagaWallet)
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
}

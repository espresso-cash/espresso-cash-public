import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../di.dart';
import '../../../routing.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../accounts/services/account_service.dart';
import '../../app_lock/app_lock.dart';
import '../../legal/privacy_screen.dart';
import '../../legal/terms_screen.dart';
import '../../view_phrase/view_phrase.dart';
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
          ValueListenableBuilder(
            valueListenable: sl<AccountService>(),
            builder: (context, value, child) => value?.wallet is! SagaWallet
                ? ProfileButton(
                    label: context.l10n.viewRecoveryPhrase,
                    description: context.l10n.viewRecoveryPhraseDescription,
                    onPressed: () => context.launchViewRecoveryPhraseFlow(),
                  )
                : const SizedBox.shrink(),
          ),
          ProfileButton(
            label: context.l10n.termsOfUse,
            onPressed: () => const TermsRoute().push<void>(context),
          ),
          ProfileButton(
            label: context.l10n.privacyPolicy,
            onPressed: () => const PrivacyRoute().push<void>(context),
          ),
        ],
      );
}

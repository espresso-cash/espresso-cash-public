import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/gen/app_localizations.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../ambassador/data/ambassador_service.dart';
import '../../ambassador/screens/share_ambassador_link_screen.dart';
import '../data/profile_repository.dart';
import 'profile_button.dart';
import 'profile_section.dart';

class AmbassadorSection extends StatelessWidget {
  const AmbassadorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: sl<AmbassadorService>(),
      builder: (context, child) {
        final status = sl<AmbassadorService>().value;

        return status.isAmbassador
            ? ProfileSection(
              title: l10n.ambassador_title,
              padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
              actions: [
                ProfileButton(
                  label: l10n.ambassador_userOnboardingLabel,
                  description: l10n.ambassador_userOnboardingDescription,
                  onPressed: () {
                    final wallet = sl<ECWallet>().publicKey;
                    final name = sl<ProfileRepository>().fullName;

                    ShareAmbassadorLinkScreen.push(context, name: name, address: wallet);
                  },
                ),
              ],
            )
            : const SizedBox.shrink();
      },
    );
  }
}

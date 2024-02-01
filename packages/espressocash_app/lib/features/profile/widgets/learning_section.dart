import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../config.dart';
import '../../../core/presentation/utils.dart';
import 'extensions.dart';
import 'profile_button.dart';
import 'profile_section.dart';

class LearningSection extends StatelessWidget {
  const LearningSection({super.key});

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.learningSectionTitle,
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          ProfileButton(
            label: context.l10n.contactUs,
            onPressed: context.launchContactUs,
          ),
          ProfileButton(
            label: context.l10n.faq,
            onPressed: () => context.openLink(faqUrl),
          ),
        ],
      );
}

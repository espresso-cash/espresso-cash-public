import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../config.dart';
import '../../../di.dart';
import '../../../ui/web_view_screen.dart';
import '../../intercom/services/intercom_service.dart';
import 'profile_button.dart';
import 'profile_section.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.helpSectionTitle,
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          ProfileButton(
            label: context.l10n.contactUs,
            onPressed: () => sl<IntercomService>().displayMessenger(),
          ),
          ProfileButton(
            label: context.l10n.faq,
            onPressed: () => context.openLink(faqUrl),
          ),
        ],
      );
}

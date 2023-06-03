import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import 'components/profile_button.dart';

@RoutePage()
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: CpAppBar(
          title: Text(context.l10n.help.toUpperCase()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Flex(
            direction: Axis.vertical,
            children: [
              ProfileButton(
                label: context.l10n.faq,
                onPressed: () => context.openLink(faqUrl),
              ),
              ProfileButton(
                label: context.l10n.contactUs,
                onPressed: () {
                  final email = Uri.encodeComponent(contactEmail);
                  final mail = Uri.parse('mailto:$email');
                  launchUrl(mail);
                },
              ),
            ],
          ),
        ),
      );
}

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../config.dart';
import '../../../../../core/presentation/utils.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../routes.gr.dart';
import '../widgets/extensions.dart';
import '../widgets/profile_button.dart';

@RoutePage()
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static const route = HelpRoute.new;

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
                onPressed: context.launchContactUs,
              ),
            ],
          ),
        ),
      );
}

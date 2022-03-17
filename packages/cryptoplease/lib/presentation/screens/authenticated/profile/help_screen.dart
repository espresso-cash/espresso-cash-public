import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/help_bottom_sheet.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/component/profile_button.dart';
import 'package:cryptoplease/presentation/utils.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

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
                label: context.l10n.sendUsEmail,
                onPressed: () => HelpBottomSheet.show(context),
              ),
            ],
          ),
        ),
      );
}

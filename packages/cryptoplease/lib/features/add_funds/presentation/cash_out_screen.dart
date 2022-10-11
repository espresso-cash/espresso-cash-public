import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/presentation/utils.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class CashOutScreen extends StatelessWidget {
  const CashOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          leading: const BackButton(),
          title: Text(context.l10n.cashOut),
        ),
        body: CpContentPadding(
          child: ListView(
            children: [
              // TODO(rhbrunetto): add to arb file
              const Text(
                'Select a partner to cash out to your bank account',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),

              CpActionSelectorButton(
                text: 'FTX',
                onPressed: () => context.openLink(ftxSupportUrl),
              ),
            ],
          ),
        ),
      );
}

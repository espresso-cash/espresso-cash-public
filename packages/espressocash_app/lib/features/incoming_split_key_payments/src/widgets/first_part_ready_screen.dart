import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/analytics/analytics_manager.dart';
import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/split_key_payments.dart';
import '../../../../core/wallet.dart';
import '../../../../di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/theme.dart';
import '../../extensions.dart';
import '../bl/pending_iskp_repository.dart';

class FirstPartReadyScreen extends StatefulWidget {
  const FirstPartReadyScreen({super.key, required this.onCancel});

  final VoidCallback onCancel;

  @override
  State<FirstPartReadyScreen> createState() => _FirstPartReadyScreenState();
}

class _FirstPartReadyScreenState extends State<FirstPartReadyScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final secondPart = SplitKeySecondLink.tryParse(link);
      if (secondPart != null) {
        sl<AnalyticsManager>().secondLinkReceived();
        _processSecondPart(secondPart);

        return true;
      }

      return false;
    });
  }

  Future<void> _processSecondPart(SplitKeySecondLink secondPart) async {
    final repository = sl<PendingISKPRepository>();

    final firstPart = await repository.load();
    if (!mounted) return;

    if (firstPart == null) {
      context.router.popForced();

      return;
    }

    try {
      final escrow = await walletFromParts(
        firstPart: firstPart.key,
        secondPart: secondPart.key,
      );
      if (!mounted) return;

      final id = await context.createISKP(escrow);
      await repository.clear();

      if (!mounted) return;
      await context.router.replace(
        IncomingSplitKeyPaymentRoute(id: id),
      );
    } on Object {
      context.router.popForced();
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: CpTheme.dark(
            child: Builder(
              builder: (context) => DecoratedBox(
                decoration: const BoxDecoration(color: CpColors.primaryColor),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Assets.icons.logoBg
                          .svg(alignment: Alignment.bottomCenter),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 62),
                              Text(
                                context.l10n.splitKeySecondLinkTitle,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const _ContentView(),
                              const SizedBox(height: 40),
                              Expanded(
                                child: Assets.images.secondLinkArtwork.image(),
                              ),
                              const SizedBox(height: 30),
                              CpButton(
                                onPressed: () => showConfirmationDialog(
                                  context,
                                  title: context.l10n.cancel,
                                  message: context
                                      .l10n.splitKeyConfirmationDialogContent,
                                  onConfirm: () {
                                    context.router.popForced();
                                    widget.onCancel();
                                  },
                                ),
                                text: context.l10n.cancel,
                                size: CpButtonSize.micro,
                                variant: CpButtonVariant.inverted,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _ContentView extends StatelessWidget {
  const _ContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 30),
          Text(
            context.l10n.splitKeySecondLinkMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
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
import '../../../../ui/bullet_item.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/theme.dart';
import '../../../legal/flow.dart';
import '../../extensions.dart';
import '../bl/pending_iskp_repository.dart';

@RoutePage()
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

      final id = await context.createISKP(
        escrow: escrow,
        version: firstPart.apiVersion,
      );
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
  Widget build(BuildContext context) => CpTheme.dark(
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: const Color(0xff2D2B2C),
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Assets.icons.logoDark.svg(
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const _Header(),
                        const SizedBox(height: 16),
                        Flexible(
                          child: Assets.rive.secondLink.rive(
                            placeHolder: const SizedBox.expand(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CpButton(
                          onPressed: () => showConfirmationDialog(
                            context,
                            title: context.l10n.cancel,
                            message:
                                context.l10n.splitKeyConfirmationDialogContent,
                            onConfirm: () {
                              context.router.popForced();
                              widget.onCancel();
                            },
                          ),
                          text: context.l10n.cancel,
                          size: CpButtonSize.micro,
                        ),
                        const SizedBox(height: 16),
                        const _TermsDisclaimer(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Assets.images.logo.image(width: 209),
          ),
          Text(
            context.l10n.splitKeySecondLinkTitle.toUpperCase(),
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          CpBulletItemWidget(text: context.l10n.splitKeySecondLinkMessage),
        ],
      );
}

class _TermsDisclaimer extends StatelessWidget {
  const _TermsDisclaimer();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text.rich(
          TextSpan(
            text: context.l10n.byClickingTheSecondLink,
            children: [
              TextSpan(
                text: context.l10n.terms,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.navigateToTermsOfUse(),
                style: const TextStyle(
                  color: CpColors.yellowColor,
                ),
              ),
              TextSpan(text: context.l10n.and),
              TextSpan(
                text: context.l10n.privacyPolicy,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.navigateToPrivacyPolicy(),
                style: const TextStyle(
                  color: CpColors.yellowColor,
                ),
              ),
            ],
            style: const TextStyle(
              fontSize: 14,
              height: 1.1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}

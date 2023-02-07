import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/analytics/analytics_manager.dart';
import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/split_key_payments.dart';
import '../../../../di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import '../bl/iskp_bloc.dart';
import '../bl/pending_iskp_repository.dart';
import 'components/cancel_dialog.dart';

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

      final id = const Uuid().v4();
      context.read<ISKPBloc>().add(ISKPEvent.create(escrow, id: id));
      await repository.clear();
      if (!mounted) return;

      await context.router.replace(IncomingSplitKeyPaymentRoute(id: id));
    } on Object {
      context.router.popForced();
    }
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: WillPopScope(
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
                                onPressed: () => showCancelDialog(
                                  context,
                                  () {
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
                    ],
                  ),
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

Future<Wallet> walletFromParts({
  required String firstPart,
  required String secondPart,
}) async {
  final keyPart1 = ByteArray.fromBase58(firstPart).toList();
  final keyPart2 = ByteArray.fromBase58(secondPart).toList();

  return Wallet.fromPrivateKeyBytes(privateKey: keyPart1 + keyPart2);
}

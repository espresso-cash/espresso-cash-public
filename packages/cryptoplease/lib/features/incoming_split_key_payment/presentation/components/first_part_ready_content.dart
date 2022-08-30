import 'package:cryptoplease/features/incoming_split_key_payment/presentation/components/cancel_dialog.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstPartReadyContent extends StatelessWidget {
  const FirstPartReadyContent({Key? key}) : super(key: key);

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
                                    .headline2
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
                                onPressed: () => showCancelDialog(context),
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
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      );
}

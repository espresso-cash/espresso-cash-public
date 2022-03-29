import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/split_key_payments/incoming/components/cancel_dialog.dart';
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
                builder: (context) => CpBackgroundGradient(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        children: [
                          Assets.images.logo.image(height: 32),
                          const SizedBox(height: 30),
                          Text(
                            context.l10n.splitKeySecondLinkTitle,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline2?.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          const _ContentView(),
                          const SizedBox(height: 40),
                          Expanded(
                            child: Assets.images.secondLinkArtwork.image(),
                          ),
                          const SizedBox(height: 30),
                          TextButton(
                            onPressed: () => showCancelDialog(context),
                            child: Text(
                              context.l10n.cancel,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
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
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style:
                  Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 24),
              children: <TextSpan>[
                TextSpan(text: context.l10n.splitKeySecondLinkMessage1),
                TextSpan(
                  text: context.l10n.splitKeySecondLinkMessage2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: context.l10n.splitKeySecondLinkMessage3),
              ],
            ),
          ),
        ],
      );
}

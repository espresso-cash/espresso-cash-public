import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/info_list.dart';
import '../../../ui/theme.dart';

class IdentityVerificationScreen extends StatelessWidget {
  const IdentityVerificationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const IdentityVerificationScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            leading: const CpBackButton(),
            title: Text(context.l10n.identityVerification.toUpperCase()),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Assets.images.profileGraphic.image(height: 80),
                  const SizedBox(height: 20),
                  Text(
                    context.l10n.identityVerificationDescription,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 21 / 16,
                      letterSpacing: .19,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Expanded(child: _Timeline()),
                  CpBottomButton(
                    horizontalPadding: 16,
                    text: context.l10n.startSelfieVerification,
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _Timeline extends StatelessWidget {
  const _Timeline();

  @override
  Widget build(BuildContext context) {
    final items = [
      CpInfoListItem(subtitle: context.l10n.identityInstruction1),
      CpInfoListItem(subtitle: context.l10n.identityInstruction2),
      CpInfoListItem(subtitle: context.l10n.identityInstruction3),
    ];

    return CpInfoList(items: items);
  }
}

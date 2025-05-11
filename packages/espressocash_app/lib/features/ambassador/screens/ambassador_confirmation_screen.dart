// ignore_for_file: avoid-wildcard-cases-with-enums

import 'package:dfunc/dfunc.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../utils/errors.dart';
import '../data/ambassador_service.dart';
import '../models/ambassador_referral.dart';
import '../widgets/ambassador_page.dart';
import 'ambassador_result_screen.dart';

class AmbassadorConfirmationScreen extends StatefulWidget {
  const AmbassadorConfirmationScreen({required this.ambassador, super.key});

  final AmbassadorReferral ambassador;

  static void push(BuildContext context, AmbassadorReferral ambassador) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => AmbassadorConfirmationScreen(ambassador: ambassador),
        ),
      );

  @override
  State<AmbassadorConfirmationScreen> createState() => _AmbassadorConfirmationScreenState();
}

class _AmbassadorConfirmationScreenState extends State<AmbassadorConfirmationScreen> {
  bool _isLoading = false;

  Future<void> _onConfirm() async {
    setState(() => _isLoading = true);

    try {
      await sl<AmbassadorService>().addReferral(widget.ambassador.address.toBase58());

      if (!mounted) return;

      AmbassadorResultScreen.push(context, AmbassadorResult.success);
    } on Exception catch (error) {
      if (!mounted) return;

      final result = error.toEspressoCashError()?.let(
        (it) => switch (it) {
          EspressoCashError.ambassadorAlreadyAssigned => AmbassadorResult.alreadyRegistered,
          EspressoCashError.userIsNotAmbassador => AmbassadorResult.notAmbassador,
          _ => null,
        },
      );

      result != null
          ? AmbassadorResultScreen.push(context, result)
          : showCpErrorSnackbar(context, message: context.l10n.tryAgainLater);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) => CpLoader(
    isLoading: _isLoading,
    child: AmbassadorPage(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.ambassador_referralProgramWelcome,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: CpColors.blackGreyColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.ambassador_referralProgramDescription,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.17,
                    color: CpColors.blackGreyColor,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  context.l10n.ambassador_benefitsIntro,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.17,
                    color: CpColors.blackGreyColor,
                  ),
                ),
                const SizedBox(height: 16),
                _BenefitItem(text: context.l10n.ambassador_benefitMerchandise),
                const SizedBox(height: 12),
                _BenefitItem(text: context.l10n.ambassador_benefitCashBonus),
                const Spacer(),
                Center(
                  child: CpButton(
                    text: context.l10n.ambassador_joinButton,
                    size: CpButtonSize.big,
                    width: 340,
                    onPressed: _onConfirm,
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

class _BenefitItem extends StatelessWidget {
  const _BenefitItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Padding(padding: const EdgeInsets.all(4), child: Assets.icons.successBullet.svg(height: 28)),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.17,
            color: CpColors.blackGreyColor,
          ),
        ),
      ),
    ],
  );
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/colors.dart';
import '../../../../legal/flow.dart';

class TermsDisclaimer extends StatelessWidget {
  const TermsDisclaimer({super.key});

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          text: context.l10n.byCreatingWalletYouAgree,
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
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 14.sp,
                height: 1.1,
                fontWeight: FontWeight.w500,
              ),
        ),
      );
}

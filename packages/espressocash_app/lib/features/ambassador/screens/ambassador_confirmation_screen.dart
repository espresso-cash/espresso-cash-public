import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../utils/errors.dart';
import '../models/ambassador_referral.dart';
import '../widgets/ambassador_page.dart';
import 'ambassador_result_screen.dart';

class AmbassadorConfirmationScreen extends StatefulWidget {
  const AmbassadorConfirmationScreen({
    required this.ambassador,
    super.key,
  });

  final AmbassadorReferral ambassador;

  static void push(BuildContext context, AmbassadorReferral ambassador) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => AmbassadorConfirmationScreen(
            ambassador: ambassador,
          ),
        ),
      );

  @override
  State<AmbassadorConfirmationScreen> createState() =>
      _AmbassadorConfirmationScreenState();
}

class _AmbassadorConfirmationScreenState
    extends State<AmbassadorConfirmationScreen> {
  bool _isLoading = false;

  Future<void> _onConfirm() async {
    setState(() => _isLoading = true);

    try {
      await sl<EspressoCashClient>().addAmbassadorReferral(
        AmbassadorReferralRequestDto(
          ambassadorAddress: widget.ambassador.address.toBase58(),
        ),
      );

      if (!mounted) return;

      AmbassadorResultScreen.push(context, AmbassadorResult.success);
    } on Exception catch (error) {
      if (!mounted) return;

      if (error is DioException &&
          error.toEspressoCashError() ==
              EspressoCashError.ambassadorAlreadyAssigned) {
        AmbassadorResultScreen.push(context, AmbassadorResult.failure);
      } else {
        showCpErrorSnackbar(context, message: context.l10n.tryAgainLater);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) => CpLoader(
        isLoading: _isLoading,
        child: AmbassadorPage(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.ambassador_referralProgramWelcome,
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                    color: CpColors.darkBackgroundColor,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.ambassador_referralProgramDescription,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.17,
                    color: CpColors.darkBackgroundColor,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  context.l10n.ambassador_benefitsIntro,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.17,
                    color: CpColors.darkBackgroundColor,
                  ),
                ),
                SizedBox(height: 16.h),
                _BenefitItem(
                  text: context.l10n.ambassador_benefitMerchandise,
                ),
                SizedBox(height: 12.h),
                _BenefitItem(
                  text: context.l10n.ambassador_benefitCashBonus,
                ),
                const Spacer(),
                CpButton(
                  text: context.l10n.ambassador_joinButton,
                  size: CpButtonSize.big,
                  width: double.infinity,
                  onPressed: _onConfirm,
                ),
              ],
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
          Container(
            padding: EdgeInsets.all(4.r),
            child: Assets.icons.successBullet.svg(height: 28),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.17,
                color: CpColors.darkBackgroundColor,
              ),
            ),
          ),
        ],
      );
}

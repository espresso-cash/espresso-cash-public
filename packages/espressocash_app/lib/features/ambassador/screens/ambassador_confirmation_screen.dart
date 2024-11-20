import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../utils/errors.dart';
import '../models/ambassador_referral.dart';
import '../widgets/ambassador_page.dart';

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

      showCpSnackbar(
        context,
        message: 'Ambassador assigned successfully',
      );
      Navigator.of(context).pop();
    } on Exception catch (error) {
      if (!mounted) return;

      final message = error is DioException &&
              error.toEspressoCashError() ==
                  EspressoCashError.ambassadorAlreadyAssigned
          ? 'Ambassador already assigned'
          : context.l10n.tryAgainLater;

      showCpErrorSnackbar(context, message: message);
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
                  'Join Referral Program',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: CpColors.darkBackgroundColor,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'By joining the referral program, you agree to be part of our ambassador network.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: CpColors.darkBackgroundColor,
                  ),
                ),
                const Spacer(),
                CpButton(
                  text: 'Confirm',
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';

enum AmbassadorResult {
  success,
  failure,
}

class AmbassadorResultScreen extends StatelessWidget {
  const AmbassadorResultScreen({
    required this.result,
    super.key,
  });

  final AmbassadorResult result;

  static void push(BuildContext context, AmbassadorResult result) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => AmbassadorResultScreen(result: result),
        ),
      );

  Color get _backgroundColor => result == AmbassadorResult.success
      ? CpColors.mediumSandColor
      : CpColors.lightSandColor;

  Color get _starColor => result == AmbassadorResult.success
      ? CpColors.lightSandColor
      : CpColors.mediumSandColor;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: _backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Assets.icons.star.svg(
                        fit: BoxFit.cover,
                        color: _starColor,
                        width: 600.w,
                        height: 600.h,
                      ),
                    ),
                    Center(
                      child: result == AmbassadorResult.success
                          ? const _SuccessContent()
                          : const _ErrorContent(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: CpButton(
                  text: context.l10n.ok,
                  size: CpButtonSize.big,
                  width: double.infinity,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      );
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent();

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IntrinsicHeight(
            child: Stack(
              children: [
                Align(
                  child: Assets.icons.confetti.svg(width: 315.w),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: Assets.icons.successCheck3.svg(width: 120.w),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            context.l10n.ambassador_enrollmentComplete,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent();

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.errorIcon2.svg(width: 111.w),
          SizedBox(height: 24.h),
          Text(
            context.l10n.ambassador_alreadyEnrolledTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            context.l10n.ambassador_alreadyEnrolledDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.17,
            ),
          ),
        ],
      );
}

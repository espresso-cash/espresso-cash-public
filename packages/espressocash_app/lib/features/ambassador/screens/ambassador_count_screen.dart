import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/text_field.dart';
import '../../profile/data/profile_repository.dart';
import '../services/ambassador_stats_service.dart';
import '../widgets/ambassador_page.dart';
import 'share_ambassador_link_screen.dart';

class AmbassadorCountScreen extends StatefulWidget {
  const AmbassadorCountScreen({super.key});

  static void push(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const AmbassadorCountScreen(),
        ),
      );

  @override
  State<AmbassadorCountScreen> createState() => _AmbassadorCountScreenState();
}

class _AmbassadorCountScreenState extends State<AmbassadorCountScreen> {
  late final String _name;
  late final Future<int> _countFuture;

  @override
  void initState() {
    super.initState();
    _name = sl<ProfileRepository>().fullName;
    _countFuture = _getCount();
  }

  Future<int> _getCount() => sl<AmbassadorStatsService>().fetchReferralCount();

  @override
  Widget build(BuildContext context) => FutureBuilder<int>(
        future: _countFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCpErrorSnackbar(context, message: context.l10n.tryAgainLater);
            });
          }

          return CpLoader(
            isLoading: !snapshot.hasData && !snapshot.hasError,
            child: AmbassadorPage(
              name: _name,
              child: Padding(
                padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: _ReferralCount(count: snapshot.data ?? 0),
                    ),
                    const Spacer(),
                    CpButton(
                      text: context.l10n.ambassador_ambassadorQrCode,
                      size: CpButtonSize.big,
                      width: 340.w,
                      onPressed: () =>
                          ShareAmbassadorLinkScreen.navigate(context),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

class _ReferralCount extends StatelessWidget {
  const _ReferralCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                context.l10n.ambassador_newUsersOnboarded,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.17,
                  color: CpColors.darkBackgroundColor,
                ),
              ),
            ),
            const SizedBox(height: 4),
            CpTextField(
              controller: TextEditingController(text: count.toString()),
              backgroundColor: CpColors.darkBackgroundColor,
              readOnly: true,
              textColor: Colors.white,
              fontSize: 34.sp,
              fontWeight: FontWeight.w700,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            ),
          ],
        ),
      );
}

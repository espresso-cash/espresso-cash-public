import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/info_list.dart';
import '../../../ui/theme.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_utils.dart';

class KycStatusScreen extends StatefulWidget {
  const KycStatusScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const KycStatusScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  State<KycStatusScreen> createState() => _KycStatusScreenState();
}

class _KycStatusScreenState extends State<KycStatusScreen> {

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: sl<KycSharingService>(),
        builder: (context, userData, child) => userData == null
            ? const CircularProgressIndicator()
            : CpTheme.black(
                child: Scaffold(
                  appBar: CpAppBar(
                    leading: const CpBackButton(),
                    title:
                        Text(context.l10n.identityVerification.toUpperCase()),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SafeArea(
                      top: false,
                      child: Column(
                        children: [
                          Assets.images.profileGraphic.image(height: 80),
                          const SizedBox(height: 20),
                          _getTitle(userData.kycStatus),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              _getDescriptionText(userData.kycStatus),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 21 / 16,
                                letterSpacing: .19,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Expanded(child: _getTimeline(userData.kycStatus)),
                          _getButton(userData.kycStatus),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      );

  Widget _getTitle(ValidationStatus status) {
    final title = switch (status) {
      ValidationStatus.approved => (
          text: context.l10n.verified,
          color: CpColors.greenLightColor,
        ),
      ValidationStatus.pending => (
          text: context.l10n.pendingApproval,
          color: CpColors.lightButtonBackgroundColor,
        ),
      ValidationStatus.rejected => (
          text: context.l10n.verificationFailed,
          color: CpColors.errorChipColor,
        ),
      ValidationStatus.unspecified || ValidationStatus.unverified => (
          text: context.l10n.verificationNotStarted,
          color: CpColors.grey,
        ),
    };

    return MarkdownBody(
      data: title.text.toUpperCase(),
      styleSheet: MarkdownStyleSheet(
        p: _titleStyle.copyWith(color: title.color),
        em: _titleStyle.copyWith(color: CpColors.yellowColor),
        textAlign: WrapAlignment.center,
      ),
    );
  }

  String _getDescriptionText(ValidationStatus status) => switch (status) {
        ValidationStatus.approved => context.l10n.kycStatusApprovedDescription,
        ValidationStatus.pending => context.l10n.kycStatusPendingDescription,
        ValidationStatus.unspecified ||
        ValidationStatus.unverified ||
        ValidationStatus.rejected =>
          context.l10n.kycStatusFailedDescription,
      };

  Widget _getTimeline(ValidationStatus status) {
    final timelineItems = switch (status) {
      ValidationStatus.pending => [
          CpInfoListItem(
            subtitle: context.l10n.kycTimelinePendingItem1,
            variant: CpInfoListVariant.light,
          ),
          CpInfoListItem(
            subtitle: context.l10n.kycTimelinePendingItem2,
            variant: CpInfoListVariant.light,
          ),
          CpInfoListItem(
            subtitle: context.l10n.kycTimelinePendingItem3,
          ),
        ],
      ValidationStatus.unverified ||
      ValidationStatus.unspecified ||
      ValidationStatus.rejected =>
        [
          CpInfoListItem(
            subtitle: context.l10n.kycTimelineRejectedItem1,
            variant: CpInfoListVariant.light,
          ),
          CpInfoListItem(
            subtitle: context.l10n.kycTimelineRejectedItem2,
            variant: CpInfoListVariant.light,
          ),
        ],
      ValidationStatus.approved => [
          CpInfoListItem(
            subtitle: context.l10n.kycTimelineApprovedItem1,
            variant: CpInfoListVariant.light,
          ),
          CpInfoListItem(
            subtitle: context.l10n.kycTimelineApprovedItem2,
            variant: CpInfoListVariant.light,
          ),
          CpInfoListItem(
            subtitle: context.l10n.kycTimelineApprovedItem3,
            variant: CpInfoListVariant.light,
          ),
        ],
    };

    return CpInfoList(items: timelineItems);
  }

  Widget _getButton(ValidationStatus status) => switch (status) {
        ValidationStatus.approved => CpBottomButton(
            horizontalPadding: 16,
            text: context.l10n.next,
            onPressed: () => Navigator.pop(context, true),
          ),
        ValidationStatus.pending => CpBottomButton(
            horizontalPadding: 16,
            text: context.l10n.returnToDashboard,
            onPressed: () => Navigator.pop(context, false),
          ),
        ValidationStatus.rejected => CpBottomButton(
            horizontalPadding: 16,
            text: context.l10n.retry,
            // TODO(vsumin): Add retry logic
            onPressed: () => Navigator.pop(context, false),
          ),
        ValidationStatus.unverified ||
        ValidationStatus.unspecified =>
          const SizedBox.shrink(),
      };
}

const _titleStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 32,
  fontWeight: FontWeight.w900,
  letterSpacing: 0.25,
  height: 1,
);

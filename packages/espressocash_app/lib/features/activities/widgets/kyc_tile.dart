// ignore_for_file: prefer-switch-with-enums

import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../kyc_sharing/models/kyc_validation_status.dart';
import '../../kyc_sharing/screens/kyc_status_screen.dart';
import '../../kyc_sharing/services/kyc_service.dart';
import '../../kyc_sharing/utils/kyc_utils.dart';
import '../../kyc_sharing/widgets/kyc_flow.dart';
import '../../kyc_sharing/widgets/kyc_listener.dart';
import '../../kyc_sharing/widgets/kyc_status_icon.dart';
import '../../ramp/widgets/ramp_buttons.dart';

class KycTile extends StatelessWidget {
  const KycTile({
    super.key,
    this.onTap,
    required this.timestamp,
  });

  final VoidCallback? onTap;
  final String timestamp;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: sl<KycSharingService>(),
        builder: (context, user, _) => user == null
            ? const SizedBox.shrink()
            : KycStatusListener(
                builder: (context, kycStatus) => _KycTileContent(
                  timestamp: timestamp,
                  kycStatus: kycStatus,
                  emailStatus: user.emailStatus.toKycValidationStatus(),
                  phoneStatus: user.phoneStatus.toKycValidationStatus(),
                ),
              ),
      );
}

class _KycTileContent extends StatelessWidget {
  const _KycTileContent({
    required this.timestamp,
    required this.emailStatus,
    required this.phoneStatus,
    required this.kycStatus,
  });

  final KycValidationStatus emailStatus;
  final KycValidationStatus phoneStatus;
  final KycValidationStatus kycStatus;
  final String timestamp;

  @override
  Widget build(BuildContext context) {
    if (emailStatus != ValidationStatus.approved) {
      return _KycItem(
        status: emailStatus,
        timestamp: timestamp,
        title: context.l10n.emailVerification,
        description: context.l10n.kycTileDescriptionUnverified,
        onPressed: context.openKycFlow,
        buttonText: context.l10n.continueVerification,
      );
    }

    if (phoneStatus != ValidationStatus.approved) {
      return _KycItem(
        status: phoneStatus,
        timestamp: timestamp,
        title: context.l10n.phoneVerification,
        description: context.l10n.kycTileDescriptionUnverified,
        onPressed: context.openKycFlow,
        buttonText: context.l10n.continueVerification,
      );
    }

    final isUnverified = kycStatus == KycValidationStatus.unverified;

    return _KycItem(
      status: kycStatus,
      timestamp: timestamp,
      title: context.l10n.idVerification,
      description: kycStatus.description(context),
      onPressed: isUnverified
          ? context.openKycFlow
          : () {
              KycStatusScreen.push(
                context,
                onAddCashPressed: context.launchOnRampFlow,
                onCashOutPressed: context.launchOffRampFlow,
              );
            },
      buttonText: isUnverified
          ? context.l10n.continueVerification
          : context.l10n.viewDetails,
    );
  }
}

class _KycItem extends StatelessWidget {
  const _KycItem({
    required this.status,
    required this.timestamp,
    required this.onPressed,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  final KycValidationStatus status;
  final String timestamp;
  final VoidCallback onPressed;
  final String title;
  final String description;
  final String buttonText;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 6, right: 20, left: 20, bottom: 26),
        decoration: const BoxDecoration(
          color: CpColors.blackGreyColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: KycStatusIcon(status, height: 42),
              title: Text(
                title,
                style: _titleStyle,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(status.subtitle(context), style: _subtitleStyle),
                  Text(timestamp, style: _subtitleStyle),
                ],
              ),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: _subtitleStyle,
            ),
            const SizedBox(height: 16),
            CpButton(
              minWidth: 180,
              size: CpButtonSize.small,
              text: buttonText,
              onPressed: onPressed,
            ),
          ],
        ),
      );
}

extension on KycValidationStatus {
  String subtitle(BuildContext context) => switch (this) {
        KycValidationStatus.approved => context.l10n.approved,
        KycValidationStatus.rejected => context.l10n.failed,
        KycValidationStatus.pending ||
        KycValidationStatus.unverified =>
          context.l10n.activities_lblInProgress,
      };

  String description(BuildContext context) => switch (this) {
        KycValidationStatus.approved => context.l10n.kycTileDescriptionApproved,
        KycValidationStatus.pending => context.l10n.kycTileDescriptionPending,
        KycValidationStatus.rejected => context.l10n.kycTileDescriptionRejected,
        KycValidationStatus.unverified =>
          context.l10n.kycTileDescriptionUnverified,
      };
}

const _titleStyle = TextStyle(
  fontSize: 16,
  letterSpacing: .23,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

const _subtitleStyle = TextStyle(
  fontSize: 14,
  color: Colors.white,
  letterSpacing: .19,
);

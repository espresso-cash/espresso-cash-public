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
import '../../kyc_sharing/widgets/kyc_status_icon.dart';

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
            : _KycTileContent(
                timestamp: timestamp,
                kycStatus: user.kycStatus,
                emailStatus: user.emailStatus,
                phoneStatus: user.phoneStatus,
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

  final ValidationStatus emailStatus;
  final ValidationStatus phoneStatus;
  final ValidationStatus kycStatus;
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

    final isUnverified = kycStatus == ValidationStatus.unspecified ||
        kycStatus == ValidationStatus.unverified;

    return _KycItem(
      status: kycStatus,
      timestamp: timestamp,
      title: context.l10n.idVerification,
      description: kycStatus.description(context),
      onPressed: isUnverified
          ? context.openKycFlow
          : () => KycStatusScreen.push(context),
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

  final ValidationStatus status;
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
              leading:
                  KycStatusIcon(status.toKycValidationStatus(), height: 42),
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

extension on ValidationStatus {
  String subtitle(BuildContext context) => switch (this) {
        ValidationStatus.approved => context.l10n.approved,
        ValidationStatus.rejected => context.l10n.failed,
        ValidationStatus.pending ||
        ValidationStatus.unverified ||
        ValidationStatus.unspecified =>
          context.l10n.activities_lblInProgress,
      };

  String description(BuildContext context) => switch (this) {
        ValidationStatus.approved => context.l10n.kycTileDescriptionApproved,
        ValidationStatus.pending => context.l10n.kycTileDescriptionPending,
        ValidationStatus.rejected => context.l10n.kycTileDescriptionRejected,
        ValidationStatus.unverified ||
        ValidationStatus.unspecified =>
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

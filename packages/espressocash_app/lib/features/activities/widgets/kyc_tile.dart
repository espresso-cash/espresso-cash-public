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
import '../../kyc_sharing/widgets/kyc_status_icon.dart';

class KycTile extends StatelessWidget {
  const KycTile({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: sl<KycSharingService>(),
        builder: (context, user, _) => user == null
            ? const SizedBox.shrink()
            : _KycTileContent(
                status: user.kycStatus,
                title: title,
              ),
      );
}

class _KycTileContent extends StatelessWidget {
  const _KycTileContent({
    required this.status,
    required this.title,
  });

  final ValidationStatus status;
  final String title;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 10, left: 10, bottom: 6),
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
              title: Expanded(
                child: Text(
                  title,
                  style: _titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Text(
                status.subtitle(context),
                style: _subtitleStyle,
              ),
            ),
            Text(
              status.description(context),
              textAlign: TextAlign.center,
              style: _subtitleStyle,
            ),
            const SizedBox(height: 16),
            CpButton(
              minWidth: 180,
              size: CpButtonSize.small,
              text: 'View details',
              onPressed: () => KycStatusScreen.push(context),
            ),
          ],
        ),
      );
}

extension on ValidationStatus {
  String subtitle(BuildContext context) => switch (this) {
        ValidationStatus.approved => context.l10n.verified,
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

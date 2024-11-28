import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../kyc_sharing/services/kyc_service.dart';
import '../../kyc_sharing/utils/kyc_utils.dart';
import '../../kyc_sharing/widgets/kyc_status_icon.dart';
import '../../ramp/partners/kyc/widgets/launch.dart';
import '../../ramp_partner/models/ramp_type.dart';

class KycTile extends StatelessWidget {
  const KycTile({
    super.key,
    required this.title,
    required this.timestamp,
    this.incomingAmount,
    this.outgoingAmount,
    this.onTap,
    required this.preOrder,
    required this.rampType,
  });

  final String title;
  final String timestamp;
  final String? incomingAmount;
  final String? outgoingAmount;
  final VoidCallback? onTap;
  final PreOrderData? preOrder;
  final RampType rampType;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: sl<KycSharingService>(),
        builder: (context, user, _) => user == null
            ? const SizedBox.shrink()
            : _KycTileContent(
                status: user.kycStatus,
                title: title,
                timestamp: timestamp,
                incomingAmount: incomingAmount,
                outgoingAmount: outgoingAmount,
                preOrder: preOrder,
                rampType: rampType,
              ),
      );
}

class _KycTileContent extends StatelessWidget {
  const _KycTileContent({
    required this.status,
    required this.title,
    required this.timestamp,
    required this.incomingAmount,
    required this.outgoingAmount,
    required this.preOrder,
    required this.rampType,
  });

  final ValidationStatus status;
  final String title;
  final String timestamp;
  final String? incomingAmount;
  final String? outgoingAmount;
  final PreOrderData? preOrder;
  final RampType rampType;

  @override
  Widget build(BuildContext context) {
    final incomingAmount = this.incomingAmount;
    final outgoingAmount = this.outgoingAmount;

    return Container(
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
            leading: KycStatusIcon(status, height: 42),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: _titleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (incomingAmount != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('+$incomingAmount', style: _inAmountStyle),
                  ),
                if (outgoingAmount != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('-$outgoingAmount', style: _titleStyle),
                  ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status.subtitle(context),
                  style: _subtitleStyle,
                ),
                Text(timestamp, style: _subtitleStyle),
              ],
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
            text: status.buttonTitle(context, rampType),
            onPressed: switch (rampType) {
              RampType.onRamp => () =>
                  context.launchKycOnRamp(preOrder: preOrder),
              RampType.offRamp => () =>
                  context.launchKycOffRamp(preOrder: preOrder),
            },
          ),
        ],
      ),
    );
  }
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

  String buttonTitle(BuildContext context, RampType rampType) => switch (this) {
        ValidationStatus.approved => rampType == RampType.onRamp
            ? context.l10n.completeDeposit
            : context.l10n.completeWithdrawal,
        ValidationStatus.unverified ||
        ValidationStatus.unspecified =>
          'Continue Verification',
        ValidationStatus.pending => context.l10n.seeDetails,
        ValidationStatus.rejected => context.l10n.retryVerification,
      };
}

const _titleStyle = TextStyle(
  fontSize: 16,
  letterSpacing: .23,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

const _inAmountStyle = TextStyle(
  fontSize: 16,
  letterSpacing: .23,
  color: CpColors.greenColor,
  fontWeight: FontWeight.w500,
);

const _subtitleStyle = TextStyle(
  fontSize: 14,
  color: Colors.white,
  letterSpacing: .19,
);
